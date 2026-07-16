---
title: Known Issues & Technical Debt Registry
category: knowledge
version: 2.0.0
last_updated: 2026-07-15
---

# KNOWN ISSUES & TECHNICAL DEBT REGISTRY

## Active Debt Inventory & Mitigation Plan

| Issue ID | Category | Severity | Description | Current Workaround | Planned Resolution Milestone |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `DEBT-DB-001`| Database | Medium | Legacy SQLite `SyncQueueTable` in older Flutter client prototypes did not hash payloads for tamper verification. | Server verifies payload validity on ingestion via `FluentValidation`. | **Phase 1 (Q3 2026):** Upgrade `Drift` schema to include `SHA256` payload signature checks. |
| `DEBT-API-001`| API | Low | Initial prototype controllers directly invoked repository methods without passing through `IMediator` CQRS handlers. | Currently being refactored by `backend_dev.md` across `FSP.Api`. | **Phase 1 (Q3 2026):** Enforce 100% MediatR dispatch across all controllers (`RULE-DDD-001`). |
