# ADR-005: Phase 3 - Advanced AI Diagnostic Copilot & IoT Telemetry Ingestion

## Status
Proposed

## Context
Phase 3 of the Field Service Platform (FSP) focuses on proactive maintenance and intelligent field support. Currently, technicians rely on manual manuals and historic logs, while asset failures are reported reactively by customers. 

## Revised Design (Post-User Advocate Review)

### 1. IoT Telemetry Ingestion Architecture
*   **Edge Computing (Bandwidth Optimization):** Azure IoT Edge deployed at gateways. Uses Deadband/Throttling to only transmit telemetry to the cloud when values change beyond a threshold (e.g., +/- 1°C).
*   **Ingestion Protocol:** MQTT via Azure IoT Hub.
*   **Data Processing:** Azure Stream Analytics (ASA) directly consuming from IoT Hub (removed Kafka to reduce complexity). Cloud only processes filtered data.
*   **Storage & Retention:** Time-Series Database (TSDB) using TimescaleDB. Raw telemetry is retained for **7 days** (`add_retention_policy`). Continuous aggregates (downsampling to hourly/daily averages) are kept for historical analysis.
*   **Alerting Engine (Human-in-the-Loop):** ASA uses **Sliding Windows** to debounce alerts. Instead of auto-generating WorkOrders, it generates an `IoT Anomaly Alert` for the Dispatcher Dashboard. Dispatchers review the alert and manually convert it to a `WorkOrder` or dismiss it.

### 2. AI Diagnostic Copilot Architecture
*   **API Gateway & Load Balancing:** Azure API Management (APIM) placed in front of OpenAI. Includes an **Emergency Bypass** quota for technicians working on `Critical` priority WorkOrders to avoid rate-limiting blocks during emergencies.
*   **AI Model:** Azure OpenAI (GPT-4o mini) for conversational intelligence with strict hallucination guardrails (must cite manual page numbers). If the AI cannot find an answer, it must provide **Fallback Actions** (e.g., Escalation to SME, Decision Tree link) rather than a dead-end response.
*   **Knowledge Base (RAG):** Migrated from `pgvector` to **Azure AI Search** to avoid RAM contention with TimescaleDB's massive memory footprint.
*   **Mobile Integration (Offline/Online Graceful Degradation):** The Chat UI remains visible when offline but changes to an offline theme (amber/grey). User natural language queries are parsed locally, and **Local SQLite Full-Text Search (FTS)** is executed to return relevant manual snippets and Decision Trees with a message clarifying the offline fallback state.

## Decision Log

### Phase 1: Skeptic / Challenger Review & Resolutions
| Objection / Challenge | Primary Designer Response & Resolution | Status |
| :--- | :--- | :--- |
| **1. AI Copilot fails completely offline & SignalR drains battery:** Techs work in dead zones; WebSocket is unstable. | **ACCEPTED (`DEC-AI-001`):** Replaced SignalR with Async Q&A Queue (Drift). Added local cached Decision Trees for offline fallback. | RESOLVED |
| **2. Hallucination Risk:** GPT-4o mini giving dangerous advice for heavy machinery. | **ACCEPTED (`DEC-AI-002`):** Added strict RAG guardrails requiring page citations. Added human-in-the-loop warning disclaimers. | RESOLVED |
| **3. WorkOrder Spam & Flapping:** Static `Temp > 80C` rule will trigger thousands of spam orders. | **ACCEPTED (`DEC-IOT-001`):** ASA Sliding Windows applied (e.g., Temp > 80C for 15 mins) to debounce and deduplicate alerts. | RESOLVED |
| **4. Architectural Bloat (Kafka + Background Worker):** Redundant components for stream processing. | **ACCEPTED (`DEC-IOT-002`):** Eliminated Kafka and Background Worker. ASA handles the direct ingestion and temporal logic. | RESOLVED |
| **5. Storage Bomb (TimescaleDB):** Raw data will consume terabytes quickly without retention. | **ACCEPTED (`DEC-IOT-003`):** Implemented continuous aggregates (downsampling) and a strict 7-day retention policy on raw telemetry. | RESOLVED |

### Phase 2: Constraint Guardian Review & Resolutions
| Objection / Challenge | Primary Designer Response & Resolution | Status |
| :--- | :--- | :--- |
| **1. Network Bandwidth & Cloud ASA Costs:** Raw stream wastes 4G and inflates SU billing. | **ACCEPTED (`DEC-IOT-004`):** Deployed Azure IoT Edge with Deadband/Throttling so only significant value shifts reach the Cloud. | RESOLVED |
| **2. RAM Contention:** TimescaleDB and `pgvector` on the same Postgres instance will crash/OOM. | **ACCEPTED (`DEC-AI-003`):** Dropped `pgvector`. Offloaded RAG vector embeddings entirely to Azure AI Search. | RESOLVED |
| **3. OpenAI API Quota & 429 Errors:** Thundering herd during peak hours causes rate limit exhaustion. | **ACCEPTED (`DEC-AI-004`):** Introduced APIM for request caching and multi-region round-robin load balancing. | RESOLVED |
| **4. Useless Offline Q&A Queue:** A delayed queue is useless for immediate troubleshooting; wastes sync battery. | **ACCEPTED (`DEC-AI-005`):** Removed Queue. UI now disables Chat AI when offline, providing instant Local SQLite FTS over downloaded manuals instead. | RESOLVED |

### Phase 3: User Advocate Review & Resolutions
| Objection / Challenge | Primary Designer Response & Resolution | Status |
| :--- | :--- | :--- |
| **1. Cognitive Load during Rate Limiting:** Hitting a quota limit during an emergency frustrates technicians. | **ACCEPTED (`DEC-UX-001`):** Configured APIM to offer an "Emergency Bypass" for `Critical` severity WorkOrders, overriding normal rate limits. | RESOLVED |
| **2. Dead-end "I don't know" AI Responses:** Leaves technicians stranded without next steps. | **ACCEPTED (`DEC-UX-002`):** Enforced a prompt rule where the AI must offer actionable Fallbacks (e.g., Remote Assist Escalation, Decision Tree links) when lacking context. | RESOLVED |
| **3. Offline Friction (Disappearing Chat UI):** Changing from Chat to Search abruptly breaks workflow. | **ACCEPTED (`DEC-UX-003`):** Chat UI persists offline but visually indicates status. Natural language input is parsed to run local SQLite FTS, returning structured manual links as a chat reply. | RESOLVED |
| **4. IoT Alert Fatigue (Crying Wolf):** Auto-generating WorkOrders from noisy sensor data reduces trust. | **ACCEPTED (`DEC-UX-004`):** ASA generates `IoT Anomaly Alerts` instead of WorkOrders. Dispatchers review and manually convert these alerts to WorkOrders (Human-in-the-Loop). | RESOLVED |

---

## Final Arbiter Disposition
**APPROVED**. All objections from the Skeptic, Constraint Guardian, and User Advocate have been successfully resolved, mitigated, and documented. The design effectively balances resilience (offline AI, edge computing), constraints (APIM, AI Search), and user experience (seamless online/offline transitions, human-in-the-loop workflows). Phase 3 is ready for technical specification and implementation scheduling.

