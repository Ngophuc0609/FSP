# ADR-004: Phase 2 Service Level Agreement (SLA) & Intelligent Dispatching Engine

## Status
APPROVED (Completed Multi-Agent Brainstorming Review Loop: Primary Designer -> Skeptic -> Constraint Guardian -> User Advocate)

## Context & Project Charter Compliance
Per the Universal Agent Header and `project_charter.md`, FSP is a production-ready enterprise Field Service Platform.
Following the successful completion and approval of Phase 1 (`ADR-002`, `ADR-003` - Work Order Management & Reactive SQLite Sync Engine), Phase 2 introduces two mission-critical core capabilities:
1. **Service Level Agreement (SLA) Management:** Enforcing strict contractual response and resolution timelines based on work order priority, customer service tiers, business hours, holiday calendars, and operational pause states with chunked index scanning and event-driven recalculation.
2. **Intelligent Dispatching & Scheduling Engine:** Assigning the right field technician to the right job at the right time using batch-prefiltered, normalized multi-variable scoring (`Skill`, `Travel Time via Routing API/Batch Matrix`, `SLA Feasibility`, `Available Capacity Minutes`) with short-lived transaction locks (`sp_getapplock` + `RowVersion`) across all manual and automated entry points.

## Approved Technical & UX Architecture

### 1. SLA Management Layer
- **DEC-SLA-001 (SLA Policies & Business Hours/Holiday Calendars):** Each `WorkOrder` is evaluated against an `SlaPolicy` that explicitly defines:
  - `TargetResponseMinutes` & `TargetResolutionMinutes`.
  - `CalendarId` (e.g., `STANDARD_MON_FRI_8_TO_17`, `24_7_EMERGENCY`, with link to tenant holiday schedules).
  - SLA calculations use **Net Working Minutes** instead of absolute UTC wall clock. Jobs created Friday at 17:00 under a Mon-Fri 8-17 calendar resume ticking on Monday at 08:00.
  - **Domino Recalculation Engine (`DEC-SLA-004`):** When a tenant's holiday calendar or technician shift schedule changes, a `CalendarChangedDomainEvent` / `ShiftChangedDomainEvent` triggers an async background queue worker (via MediatR outbox / Service Bus) to re-compute and update `NextCheckpointUtc` for affected open work orders in paginated chunks.
- **DEC-SLA-002 (SLA Tracking & Pause States):** `WorkOrderSlaTracker` (Value Object/Entity attached to `WorkOrder`) tracks:
  - `SlaStatus`: `OnTrack`, `Warning`, `Breached`, `Paused` (when status is `WaitingForCustomer` or `WaitingForParts`).
  - `AccumulatedWorkingMinutes`: Net active minutes elapsed.
  - `NextCheckpointUtc`: The exact UTC timestamp when the next threshold (Warning at 80% or Breach at 100%) will be reached.
  - `WarningNotifiedUtc` & `BreachNotifiedUtc`: Idempotent flags to prevent notification spam.
- **DEC-SLA-003 (SLA Monitoring & Chunked Sweeper):** A background worker service (`SlaMonitoringBackgroundService`) scans pending work orders:
  - **Composite Filtered Index (`RULE-BACKEND-002`):** Requires SQL Server Composite Filtered Index:
    `CREATE INDEX IX_WorkOrders_SlaSweep ON WorkOrders (TenantId, SlaStatus, NextCheckpointUtc) INCLUDE (WarningNotifiedUtc, BreachNotifiedUtc) WHERE SlaStatus IN (1, 2) AND (WarningNotifiedUtc IS NULL OR BreachNotifiedUtc IS NULL);`
  - **Chunked Processing (`FETCH NEXT 500 ROWS ONLY`):** To prevent lock contention and transaction log bottlenecks, the sweeper processes rows in batches of 500 within short-lived transactions (`IDbContextTransaction` < 50ms).
  - **Distributed Lock:** Uses short-lived SQL AppLock (`sp_getapplock` at `Transaction` scope inside the chunk loop) or Redis Redlock with fencing token to ensure only 1 pod executes a given chunk.

### 2. Technician Skills & Certifications
- **DEC-SKILL-001 (Skill Catalog & Proficiency):** Master catalog entity `Skill` (e.g., `HVAC-REPAIR`, `HIGH-VOLTAGE-380V`). Junction entity `TechnicianSkill` linking a technician to a skill with a `ProficiencyLevel` (1=Beginner, 2=Intermediate, 3=Expert) and `ExpiryDateUtc` (for required safety certifications).
- **DEC-SKILL-002 (Work Order Skill Requirements):** `WorkOrder` specifies required skills via `WorkOrderRequiredSkill` (`SkillId`, `MinProficiencyLevel`, `IsMandatory`).

### 3. Geolocation & Real-Time Tracking
- **DEC-GPS-001 (Technician Location Pings, GDPR Privacy Guard & Retention):** Mobile app sends periodic telemetry (`TechnicianLocationPing`) via SignalR `LocationTrackingHub` or REST.
  - **GDPR Shift-Verification Guard (`RULE-SEC-001`):** Ingestion endpoints (WebSocket Hub & REST API) strictly verify `TechnicianStatus == OnShift` against cached shift state before processing. Any GPS ping received while off-shift, on lunch break, or during holidays is instantly rejected (`403 Forbidden` / dropped) and never stored in Redis or SQL Server to prevent unauthorized employee surveillance per GDPR Art. 6 & 9.
  - **Data Retention & Purging Policy (`DEC-GPS-003`):** `TechnicianLocationHistory` in SQL Server uses table partitioning by month. Data is retained in hot storage for **30 days** for operational audit, then automatically anonymized/archived to Blob Storage and purged via `PARTITION SWITCH / TRUNCATE` to limit DB storage costs and fulfill GDPR Right to be Forgotten.
- **DEC-GPS-002 (Geo Heartbeat Pattern & Stream Backlog Capping):**
  - **Heartbeat ZSET Expire Score Pattern (`DEC-GPS-004`):** Since Redis `GEO` Sorted Sets do not support per-member TTLs, when adding coordinates (`GEOADD fsp:tenant:{id}:tech:locations`), the system simultaneously adds the technician to a heartbeat sorted set: `ZADD fsp:tenant:{id}:tech:heartbeats {current_timestamp_utc} {technicianId}` along with the Hash `fsp:tenant:{id}:tech:{id}:location` (30m TTL). A lightweight background timer executes `ZREMRANGEBYSCORE fsp:tenant:{id}:tech:heartbeats 0 {current_timestamp - 1800}` every 2 minutes, retrieves expired technician IDs, and pipelines `ZREM` on the `GEO` index. This guarantees zero "ghost coordinates" with $O(\log N + M)$ efficiency.
  - **Stream Backlog Bound (`MAXLEN`):** Raw pings are buffered in Redis Streams before batch-flushing to SQL Server every 5 minutes. Every write enforces approximate capping: `XADD fsp:tenant:{id}:tech:pings MAXLEN ~ 100000 * ...` to prevent Out-Of-Memory (OOM) crashes under high burst loads.
- **DEC-GPS-005 (SignalR Backpressure, Spatial Bounding Box & Token Validation):**
  - **Spatial Bounding Box Filtering:** Dispatchers subscribe to specific viewport bounds (`SubscribeBoundingBox(southWest, northEast)`). `LocationTrackingHub` debounces and throttles location updates to **max 1Hz per dispatcher client** using `Channel<T>` backpressure to prevent WebSocket fan-out storms.
  - **Persistent JWT Expiration & ABAC Guard (`HubFilter`):** A custom SignalR `HubFilter` (`JwtExpirationAndTenantHubFilter`) intercepts every incoming WebSocket frame to verify that the JWT bearer token is still valid (not expired/revoked) and enforces strict cryptographic `TenantId` claims and branch-level ABAC scope. Expired sockets are immediately disconnected via `Context.Abort()`.

### 4. Intelligent Dispatching & Scoring Engine
- **DEC-DISP-001 (Normalized Batch Scoring Engine):**
  - **Batch Fetching & Pre-Filtering (Zero N+1 RPCs):** The Application Layer (`GetDispatchRecommendationsQueryHandler` / `AutoAssignWorkOrderCommandHandler`) first queries SQL Server/Redis to pre-filter active, on-shift technicians who possess all mandatory skills (`ProficiencyLevel >= MinProficiencyLevel` & valid `ExpiryDateUtc`). It fetches their current location pings and active calendar assignments in a single batch query (`IReadOnlyList<TechnicianCandidateContext>`).
  - **In-Memory Domain Scoring (`DispatchScoringEngine.ScoreCandidates`):** Receives the pre-filtered `TechnicianCandidateContext` list and applies **Min-Max Normalization to $[0, 100]$** across all dimensions before calculating total score:
    $$S_{total} = w_1 \cdot \text{Norm}(S_{skill}) + w_2 \cdot \text{Norm}(S_{travel}) + w_3 \cdot \text{Norm}(S_{sla}) + w_4 \cdot \text{Norm}(S_{capacity})$$
    - **Skill Score ($S_{skill}$ - weight 25%):** Exact match scores 100. Higher proficiency gives modest bonus.
    - **Travel Time / Distance Score ($S_{travel}$ - weight 35%):** Uses routing engine matrix (or road-network adjusted Haversine factor $1.4 \times \text{Euclidean}$ when external routing API is unavailable/cached).
    - **SLA Feasibility Score ($S_{sla}$ - weight 25%):** Assesses whether travel time + estimated job duration fits before `NextCheckpointUtc`.
    - **Available Capacity Windows ($S_{capacity}$ - weight 15%):** Measures **Free Working Minutes remaining in current shift**.
- **DEC-DISP-002 (Dispatch Execution & Double-Booking Prevention across all Entry Points):**
  - **Recommendation Mode (`GetDispatchRecommendationsQuery`):** Returns top candidates with detailed score breakdown + spatial coordinates for Map/Gantt timeline visualization in Dispatcher UI.
  - **Unified Race-Condition Lock (`DEC-DISP-003`):** Whether initiated via Auto-Dispatch (`AutoAssignWorkOrderCommand`), Manual Gantt drag-and-drop (`ManualAssignWorkOrderCommand`), or Mobile shift swap (`SwapAssignmentCommand`), every assignment handler must acquire a short-lived **SQL AppLock (`sp_getapplock` at `Transaction` scope on key `lock:tenant:{id}:tech:{technicianId}`)** AND verify `RowVersion` optimistic concurrency on `TechnicianAvailability` schedule slots. If a lock collision or version mismatch occurs, auto-dispatch falls back to candidate #2, while manual dispatch returns `409 Conflict` to the UI.

### 5. Presentation Layer & UX Architecture (`UX-COMPLEMENTS`)
To guarantee minimal cognitive load, zero field errors under extreme environmental conditions, and transparent customer relations, all presentation layers (Flutter Mobile, Web Dashboard, Customer Portal) must strictly adhere to these 6 UX specifications:

| Code | Target User | Core UI/UX Specification | Technical Dependency |
| :--- | :--- | :--- | :--- |
| **UX-TECH-001** | Field Technician (`Flutter`) | **Smart Shift Guard Banner:** When `LocationTrackingHub` rejects a GPS ping due to `OffShift` state (`403 Forbidden` from `RULE-SEC-001`), the app NEVER shows technical HTTP error toasts. Instead, when motion $>500m$ or upcoming job start time is detected while off-shift, the app displays a persistent amber top banner: *"⚠️ Bạn đang di chuyển nhưng chưa Bắt đầu Ca làm (Clock In). Hệ thống tạm dừng ghi nhận GPS để bảo vệ quyền riêng tư. [BẤM VÀO CA NGAY]"*. Clicking `En Route` prompts a soft modal to clock in first. | `DEC-GPS-001` (`OnShift` GDPR Guard) |
| **UX-TECH-002** | Field Technician (`Flutter`) | **High-Impact En-Route Intercept:** If a technician is currently `En Route` to Job A and an SLA Auto-Dispatch priority swap revokes Job A and re-assigns Job B, the mobile app triggers a **High-Priority Fullscreen Alert** with emergency audio/vibration: *"🔴 THAY ĐỔI LỆNH ĐIỀU PHỐI KHẨN CẤP — HỦY LỆNH CŨ: WO-1042 — LỆNH MỚI: WO-2099 (cách 3.2km) [🧭 DẪN ĐƯỜNG TỚI JOB MỚI NGAY]"* (occupying 50% bottom width). Revoked jobs remain visible in history marked *"Đã điều chuyển cho KTV khác"*. | `AutoAssignWorkOrderCommand` |
| **UX-TECH-003** | Field Technician (`Flutter`) | **Sunlight-Proof & Glove Ergonomics (`RULE-FLUTTER-003+`):** All core job action buttons (`Check-In`, `Pause SLA`, `Complete`) must be minimum **`64x52 logical pixels`** (exceeding `RULE-FLUTTER-003` 48x48) with $16px$ spacing for thick safety gloves. SLA status badges must use 3-layer ergonomics (Color + Icon + Text: `🟢 [✓] On Track - Còn 2h 15m`, `🟡 [⚠️] Chú ý - Còn 25m`, `🔴 [🚨] Quá hạn SLA - Quá hạn 12m` with subtle pulsing border). Countdowns display coarse hours/minutes (`1h 20m`) with NO ticking seconds to prevent stress. | `DEC-SLA-002` (SLA Tracker Statuses) |
| **UX-DISP-001** | Dispatcher (`Web Dashboard`) | **Zero-Cognitive-Load Candidate Cards:** Top 3 dispatch recommendations (`GetDispatchRecommendationsQuery`) display: (1) Tech Avatar, Name, Total Badge (`85/100`), (2) Natural-language summary generated by Application layer (e.g., *"💡 Gợi ý tối ưu vì: Di chuyển nhanh nhất (12 phút / 3.5km) & Kỹ năng khớp tuyệt đối"*), and (3) 4 visual mini progress bars for `Skill (100%)`, `Travel (85%)`, `SLA (100%)`, and `Capacity (60%)` instead of raw math scores. | `DEC-DISP-001` (Normalized Scoring Engine) |
| **UX-DISP-002** | Dispatcher (`Web Dashboard`) | **Actionable Conflict Dialog (`409 Conflict`):** When Gantt chart drag-and-drop encounters `409 Conflict` due to concurrent UI modification or Auto-Dispatch race condition, the dashboard instantly refreshes local Gantt state to show the new assignment and pops an actionable recovery dialog: *"⚠️ Không thể gán KTV Nguyễn Văn A cho WO-1089 vì vừa được gán vào WO-1090 trước đó vài giây. 💡 Đề xuất thay thế ngay lập tức (Ứng viên #2 tốt nhất): KTV Lê Văn C (82/100 - Di chuyển 16p). [ GÁN CHO KTV LÊ VĂN C NGAY ]"*. | `DEC-DISP-002` (`sp_getapplock` + `RowVersion`) |
| **UX-CUST-001** | Customer & Technician (`Portal/Push`) | **Transparent Mutual SLA Pause Audit:** When a technician clicks `[Tạm dừng SLA - Chờ khách hàng]` (`WaitingForCustomer` due to locked door/no access), the mobile app requires capturing 1 mandatory photo proof with timestamp and GPS watermark. Simultaneously, multi-channel notifications (SMS/Zalo/Portal Push) alert the customer: *"🔔 KTV Nguyễn Văn A đã đến địa điểm xử lý WO-1089 lúc 10:15. Trạng thái SLA: ĐANG TẠM DỪNG do chờ mở cửa/tiếp cận mặt bằng..."*. Customer Portal audit log publicly records exact paused duration (`10:15 - 10:35: Paused 20m`), eliminating post-job SLA disputes. | `DEC-SLA-002` (`WaitingForCustomer` Pause State) |

## Architecture Layer Breakdown

### Domain Layer (`FSP.Domain`)
- Entities: `SlaPolicy`, `Skill`, `TechnicianSkill`, `WorkOrderRequiredSkill`, `TechnicianLocationHistory`.
- Value Objects: `WorkOrderSlaTracker`, `GeoCoordinates`, `DispatchScoreBreakdown`, `TechnicianCandidateContext`.
- Domain Services: `IDispatchScoringEngine`.
- Domain Events: `SlaWarningDomainEvent`, `SlaBreachedDomainEvent`, `TechnicianLocationUpdatedDomainEvent`, `CalendarChangedDomainEvent`.

### Application Layer (`FSP.Application`)
- Commands: `CreateSlaPolicyCommand`, `AssignTechnicianSkillCommand`, `UpdateTechnicianLocationCommand`, `AutoAssignWorkOrderCommand`, `ManualAssignWorkOrderCommand`.
- Queries: `GetDispatchRecommendationsQuery`, `GetTechnicianLocationsQuery`, `GetSlaDashboardMetricsQuery`.
- Background Processing: `SlaMonitoringWorker` (chunked 500 rows with composite index).

### Infrastructure Layer (`FSP.Infrastructure`)
- Redis Integration: `RedisGeoLocationService` with Geo Heartbeat ZSET pattern (`ZREMRANGEBYSCORE`), `MAXLEN ~ 100000` stream ingestion.
- SQL Server EF Core Configurations: Composite filtered index `IX_WorkOrders_SlaSweep`, partitioned 30-day retention `TechnicianLocationHistory`.

### Presentation / API Layer (`FSP.Api` & `src/flutter`)
- `DispatchingController`: REST endpoints for recommendations and manual/auto assignment (`sp_getapplock` + `RowVersion`).
- `LocationTrackingHub` (SignalR): High-frequency WebSocket ingestion with GDPR `OnShift` verification, spatial bounding box filtering (1Hz debounce), and `JwtExpirationAndTenantHubFilter`.
- `Flutter Mobile App`: Implements `UX-TECH-001..003` and `UX-CUST-001` with `Drift` offline tracking, minimum `64x52px` touch targets, and sunlight-proof SLA badges.

## Decision Log (Multi-Agent Brainstorming Audit Trail)

### Phase 1: Skeptic / Challenger Review & Resolutions
| Objection / Challenge | Primary Designer Response & Resolution | Status |
| :--- | :--- | :--- |
| **1. Redis Blind Filtering & N+1 Queries** | **ACCEPTED (`DEC-DISP-001`):** Batch Pre-Filtering in SQL/Redis first, passing `IReadOnlyList<TechnicianCandidateContext>` to purely in-memory `DispatchScoringEngine`. | RESOLVED |
| **2. Ghost Coordinates & Redis Sorted Set TTL** | **ACCEPTED (`DEC-GPS-001`):** Dual-written to Redis Hash with 30m TTL and `GEOADD`. Expired hashes cleaned via heartbeat set (`DEC-GPS-004`). | RESOLVED |
| **3. SQL Write Bottleneck (`TechnicianLocationHistory`)** | **ACCEPTED (`DEC-GPS-001`):** Buffered in Redis stream and batch-flushed every 5 minutes or $>500m$ displacement. | RESOLVED |
| **4. Haversine vs Real Traffic & Normalization** | **ACCEPTED (`DEC-DISP-001`):** Min-Max Normalization to $[0, 100]$. Travel uses routing matrix or road-network factor ($1.4 \times$). | RESOLVED |
| **5. Workload Paradox & Over-qualification** | **ACCEPTED (`DEC-DISP-001`):** Uses **Available Capacity Minutes ($S_{capacity}$)**. Modest bonus cap for higher proficiency. | RESOLVED |
| **6. 60-second Table Scan & Business Hours/Pause States** | **ACCEPTED (`DEC-SLA-001..003`):** Uses Net Working Minutes per `CalendarId`, supports `SlaStatus.Paused`, queries indexed `NextCheckpointUtc`. | RESOLVED |
| **7. Double-Booking Race Condition** | **ACCEPTED (`DEC-DISP-002`):** Unified lock (`sp_getapplock` + `RowVersion`) across all assignment entry points. | RESOLVED |

### Phase 2: Constraint Guardian Review & Resolutions
| Objection / Challenge | Primary Designer Response & Resolution | Status |
| :--- | :--- | :--- |
| **1. Ghost Coordinates & Redis Geo Lack of per-member TTL:** `ZREM` via Keyspace Notifications is fire-and-forget and unreliable under pod restarts. | **ACCEPTED & REVISED (`DEC-GPS-004`):** Implemented **Heartbeat ZSET Expire Score Pattern**. Every `GEOADD` also writes `ZADD fsp:tenant:{id}:tech:heartbeats {current_unix_utc} {techId}`. A background timer runs `ZREMRANGEBYSCORE` every 2 minutes and pipelines `ZREM` on the Geo index for expired IDs ($O(\log N + M)$). Zero N+1 or full scans. | RESOLVED |
| **2. SignalR Fan-out Storm & Lack of Backpressure:** Broadcasting 333+ pings/sec to hundreds of dispatchers causes OOM and browser freezes. | **ACCEPTED & REVISED (`DEC-GPS-005`):** Implemented **Spatial Bounding Box Filtering (`SubscribeBoundingBox`)**, debounced 1Hz push per client, and `Channel<T>` backpressure to control WebSocket frame delivery rates. | RESOLVED |
| **3. SLA Sweeper Transaction Log Bottleneck & Lock Contention:** Scanning 100k rows without composite index and updating thousands of rows in 1 transaction causes timeouts. | **ACCEPTED & REVISED (`DEC-SLA-003`):** Required SQL Server Composite Filtered Index `IX_WorkOrders_SlaSweep` on `(TenantId, SlaStatus, NextCheckpointUtc) INCLUDE (...)`. Sweeper processes paginated chunks of 500 (`FETCH NEXT 500 ROWS ONLY`) within short-lived (`<50ms`) transactions. | RESOLVED |
| **4. Split-Brain Redis Lock vs AppLock Pool Exhaustion:** Redlock split-brain under replication failover; holding session AppLock drains ADO.NET pool. | **ACCEPTED & REVISED (`DEC-DISP-003`):** Standardized on short-lived SQL `sp_getapplock` (`Transaction` scope inside chunk/handler) combined with optimistic `RowVersion` verification on `TechnicianAvailability`. All entry points (Auto, Manual Gantt, Mobile swap) share this exact lock hierarchy. | RESOLVED |
| **5. Outside Working Hours Surveillance & GDPR PII Violation:** Ingesting GPS pings off-shift violates employee privacy laws. | **ACCEPTED & REVISED (`RULE-SEC-001` & `DEC-GPS-001`):** Ingestion endpoints (SignalR Hub & REST) enforce strict **Shift Verification Guard (`TechnicianStatus == OnShift`)**. Off-shift pings are instantly rejected (`403 Forbidden`) and never stored. | RESOLVED |
| **6. No Data Retention Policy for `TechnicianLocationHistory`:** 28.7M pings/day fills database indefinitely without cleanup. | **ACCEPTED & REVISED (`DEC-GPS-003`):** `TechnicianLocationHistory` is partitioned by month in SQL Server with **30-day hot retention**, then archived to Blob Storage and purged via `PARTITION SWITCH / TRUNCATE` to comply with GDPR Right to be Forgotten. | RESOLVED |
| **7. SignalR RBAC/ABAC & JWT Token Expiration on active WebSockets:** Persistent WebSocket connections don't check if JWT expired after initial handshake. | **ACCEPTED & REVISED (`DEC-GPS-005`):** Implemented `JwtExpirationAndTenantHubFilter` intercepting every incoming frame to re-validate JWT expiry and verify cryptographic `TenantId` + branch ABAC scope. Expired sockets call `Context.Abort()`. | RESOLVED |
| **8. Redis Stream OOM Spikes under DB slowdown:** `XADD` without bounds fills RAM when SQL consumer slows down. | **ACCEPTED & REVISED (`DEC-GPS-002`):** All stream insertions enforce approximate capping: `XADD fsp:tenant:{id}:tech:pings MAXLEN ~ 100000 ...` ensuring memory safety. | RESOLVED |
| **9. Domino Recalculation on Calendar/Shift Mutations:** Changing holiday calendars leaves stale `NextCheckpointUtc` across 100k jobs. | **ACCEPTED & REVISED (`DEC-SLA-004`):** When calendar or shift changes occur, `CalendarChangedDomainEvent` / `ShiftChangedDomainEvent` triggers background queue workers to recalculate `NextCheckpointUtc` across affected work orders in chunks. | RESOLVED |
| **10. Local Storage Exhaustion & Network Burst from Offline Photos:** Syncing too many photos when network returns causes bandwidth spike and out-of-storage on device. | **ACCEPTED & REVISED:** Local attachment queue on Mobile is strictly capped at **50MB**. Photos are compressed locally by default. | RESOLVED |

### Phase 3: User Advocate Review & Resolutions
| Objection / Challenge | Primary Designer Response & Resolution | Status |
| :--- | :--- | :--- |
| **1. Silent `403` on Off-Shift GPS ingestion confuses field techs** | **ACCEPTED (`UX-TECH-001`):** App intercepts `OffShift` state/403 rejection to show persistent amber shift banner and prompt soft clock-in modal on `En Route`. | RESOLVED |
| **2. SLA Auto-Dispatch revocation while Tech is driving at high speed** | **ACCEPTED (`UX-TECH-002`):** High-priority fullscreen alert with emergency audio/vibration intercepts active `En Route` navigation, showing large `[🧭 DẪN ĐƯỜNG TỚI JOB MỚI]` button. | RESOLVED |
| **3. Small touch targets and ticking countdowns under direct sunlight** | **ACCEPTED (`UX-TECH-003`):** Enforces minimum `64x52px` touch buttons (`RULE-FLUTTER-003+`), 3-layer SLA badges (`Color + Icon + Text`), and coarse `Hours/Minutes` countdown without ticking seconds. | RESOLVED |
| **4. Cognitive load from raw $[0, 100]$ dispatch score calculation** | **ACCEPTED (`UX-DISP-001`):** Candidate recommendation cards present a natural-language reason summary (`Why this tech?`) + 4 visual mini progress bars (`Skill`, `Travel`, `SLA`, `Capacity`). | RESOLVED |
| **5. Frustration when encountering `409 Conflict` during Gantt drag-and-drop** | **ACCEPTED (`UX-DISP-002`):** UI auto-syncs local Gantt state and pops an actionable recovery dialog showing Candidate #2 with a single `[ GÁN CHO KTV LÊ VĂN C NGAY ]` click button. | RESOLVED |
| **6. Customer disputes when SLA clock is paused (`WaitingForCustomer`)** | **ACCEPTED (`UX-CUST-001`):** Tech captures 1 watermarked photo proof when pausing. Instant SMS/Zalo/Portal alerts notify customer, and Portal audit log records transparent paused duration. | RESOLVED |
| **7. Compression blurs critical barcode/serial details** | **ACCEPTED:** Add a `Giữ ảnh gốc (High-Res)` toggle on the mobile attachment UI. | RESOLVED |
| **8. App crashes or loses data when offline queue reaches 50MB** | **ACCEPTED:** Display a warning UI when the queue hits 80% (40MB) and disable the camera button at 100% to protect device stability. | RESOLVED |
| **9. Dispatcher anxiety due to 15-second SLA debouncing** | **ACCEPTED:** Show a translucent `Đang đồng bộ...` (Syncing) indicator on the Web UI during the debounce window. | RESOLVED |
| **10. Silent Push for GPS causes privacy anxiety** | **ACCEPTED:** Always display a transparent Local Notification ("Ca làm việc đã bắt đầu, GPS đang bật") when Silent Push wakes the app. | RESOLVED |
| **11. Infinite loading spinners during job grab contention (Thundering Herd)** | **ACCEPTED:** Implement Fast-fail on the mobile app. Reject immediately if lock is unavailable with a fair message ("Đồng nghiệp khác đã nhận"). | RESOLVED |
