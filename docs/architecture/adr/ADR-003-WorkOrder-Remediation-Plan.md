# ADR-003: Work Order Module Remediation & Zero-Placeholder Plan

- **Status:** APPROVED
- **Date:** 2026-07-16
- **Authors:** AI Engineering Team & Senior Review Council
- **Scope:** Phase 1 Work Order Management Remediation (`src/backend/` & `src/flutter/`)

---

## 1. Executive Summary & Understanding Lock

### 1.1 Purpose
The purpose of this document is to establish the technical blueprint and execution plan for remediating architectural findings identified during the `ADR-002` Phase 1 QA Audit. This plan resolves high-priority issues surrounding in-memory mocks, clustered index fragmentation, and attachment workflows, elevating the module status from `NEEDS REVISION` to `APPROVED FOR PRODUCTION`.

### 1.2 Understanding Summary
- **What is being built:** Full implementation of `P0 + P1 + P2` remediation items for Work Order Management across ASP.NET Core (`FSP.Backend`) and Flutter Mobile (`FSP.Mobile`).
- **Why it exists:** To eliminate zero-placeholder violations (specifically replacing the `_localCache` RAM mock with reactive `Drift SQLite` storage), optimize SQL Server B-Tree index insertion performance via COMB Sequential GUIDs, and enable pre-signed cloud attachment workflows.
- **Who it is for:** Field Service Technicians operating in low-connectivity environments with protective gloves (`RULE-FLUTTER-003`), and Backoffice Dispatchers managing enterprise schedules.
- **Key Constraints:**
  - Mandatory CQRS/MediatR Monad `Result<T>` mapping to `RFC 7807 ProblemDetails`.
  - Zero-Trust Multi-Tenant data isolation via `TenantId` Global Query Filters.
  - Ergonomic touch targets (`minWidth: 48, minHeight: 48` logical pixels) across all mobile interactive widgets.

### 1.3 Assumptions
- Local Drift SQLite storage maintains up to `5,000 recent work orders` per device with automated cache eviction (>30 days completed).
- Pre-Signed URLs for attachments support up to `15MB per file` with a `15-minute expiration` window.
- Cellular disconnects or API errors (`5xx`) trigger `Exponential Backoff Retry` (2s, 4s, 8s, max 5 attempts).
- Concurrency conflicts (`409 Conflict`) are queued into a dedicated UI bottom sheet (`Conflict Resolution Queue`) for user override decision.

---

## 2. Decision Log

| ID | Decision Title | Context & Alternatives Considered | Final Choice & Rationale |
| :--- | :--- | :--- | :--- |
| **DEC-REM-001** | **Reactive Drift SQLite over In-Memory Mocks** | *Context:* `WorkOrderRepositoryImpl` used an in-memory list (`_localCache`) as a placeholder. *Alternatives:* (A) In-memory list with manual JSON file persistence; (B) Drift SQLite reactive DAOs (`.watch()`). | **Choice: Drift SQLite Reactive DAOs.** Ensures 100% data durability across OS process kills and satisfies the Zero-Placeholder policy while providing instant 0ms rendering to Riverpod notifiers. |
| **DEC-REM-002** | **COMB Sequential GUID Generator** | *Context:* Default `Guid.NewGuid()` generates UUIDv4, causing page splits on SQL Server clustered indexes. *Alternatives:* (A) Default NEWID(); (B) INT/BIGINT auto-increment IDs; (C) `SequentialGuidValueGenerator` (`COMB`). | **Choice: EF Core `SequentialGuidValueGenerator`.** Maintains GUID compatibility across distributed systems while ordering time bytes first, achieving `O(log N)` sequential insert performance. |
| **DEC-REM-003** | **Three-Step Pre-Signed URL Attachments** | *Context:* Field technicians need to upload high-res equipment photos (`<= 15MB`). *Alternatives:* (A) Direct multipart/form-data upload through ASP.NET Core API; (B) Direct cloud upload via SAS/Pre-Signed URL. | **Choice: Three-Step Pre-Signed URL Pipeline.** Prevents API server memory pressure and bandwidth exhaustion by routing heavy binary streams directly to Blob Storage (`DEC-WO-005`). |
| **DEC-REM-004** | **Ergonomic Conflict Resolution Queue UI** | *Context:* RowVersion mismatches cause `409 Conflict` during sync. *Alternatives:* (A) Silent local drop; (B) Silent server overwrite; (C) Interactive bottom sheet queue. | **Choice: Interactive Conflict Bottom Sheet.** Preserves technician field contributions while enforcing `48x48 logical pixels` touch targets (`RULE-FLUTTER-003`) for easy glove selection. |

---

## 3. Detailed Architectural Design (`Modular Reactive Sync Engine`)

### 3.1 Mobile Drift SQLite Layer (`P0`)
- **Schema Extensions (`LocalWorkOrders`):**
  - `clientReferenceId`: `TextColumn` (Unique index for idempotency check).
  - `syncStatus`: `IntColumn` (`0` = Synced, `1` = Pending, `2` = Conflict/Error).
  - `syncErrorMessage`: `TextColumn` (Nullable error details).
  - `rowVersion`: `TextColumn` (Nullable base64 string matching SQL Server `rowversion`).
- **Reactive DAO (`WorkOrdersDao`):**
  - Encapsulates pure reactive queries using `Drift` streams (`.watch()`).
  - Repository injects `WorkOrdersDao` and triggers non-blocking background sync pipelines (`unawaited(syncEngine.syncPending())`).

### 3.2 Backend COMB Sequential GUID Layer (`P1`)
- **Entity Configurations:**
  - In `WorkOrderConfiguration.cs` and `TenantConfiguration.cs`:
    ```csharp
    builder.Property(e => e.Id)
           .ValueGeneratedOnAdd()
           .HasValueGenerator<SequentialGuidValueGenerator>();
    ```
- **Idempotency Guard:**
  - `CreateWorkOrderCommandHandler` checks unique index `(TenantId, ClientReferenceId)` and wraps `SaveChangesAsync()` to catch `DbUpdateException`, ensuring duplicate mobile retry packets do not create duplicate database rows.

### 3.3 Attachment & Conflict Resolution Pipelines (`P2`)
- **Attachments (`Three-Step Pipeline`):**
  1. `POST /api/v1/work-orders/{id}/attachments/upload-url` $\rightarrow$ Returns `PreSignedUrlResponse`.
  2. Mobile puts binary file to cloud `UploadUrl`.
  3. `POST /api/v1/work-orders/{id}/attachments/confirm` $\rightarrow$ Persists metadata (`FileName`, `FileSize`, `BlobPath`) in `WorkOrderAttachments`.
- **Conflict Queue (`DEC-WO-004`):**
  - When `syncStatus == 2`, `SyncStatusBar` displays a red banner (`Colors.red.shade700`).
  - Clicking opens `ConflictBottomSheet` (`minHeight: 48` buttons) allowing either **Overwrite Local** (fetch server latest) or **Force Push** (re-sync with latest server `RowVersion`).

---

## 4. Verification & Testing Strategy

### 4.1 Automated Verification Plan
- **Static Analysis:**
  - `dotnet build src/backend/FSP.sln` $\rightarrow$ Must produce `0 Warning(s), 0 Error(s)`.
  - `flutter analyze` inside `src/flutter` $\rightarrow$ Must produce `No issues found!`.
- **Backend Unit & Integration Tests (`xUnit`):**
  - `SequentialGuidGenerationTest`: Asserts GUID ordering monotonicity across consecutive entity creations.
  - `IdempotencyDuplicateCommandTest`: Verifies double-submission with identical `ClientReferenceId` returns identical entity ID without throwing unique constraint crashes.
- **Mobile Offline & Sync Tests (`flutter_test` + In-Memory SQLite):**
  - `DriftWorkOrdersDaoTest`: Asserts `.watchAll()` emits stream updates under `15ms` when inserting items into in-memory SQLite.
  - `SyncEngineBackoffTest`: Simulates network timeouts and confirms `syncStatus` remains `1` (`Pending`) with correct retry intervals.
