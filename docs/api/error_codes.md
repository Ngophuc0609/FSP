---
title: Canonical API Error Codes & Diagnostics Catalog
category: api
version: 2.0.0
last_updated: 2026-07-15
---

# CANONICAL API ERROR CODES CATALOG

## Domain-Specific Error Code Reference

| Error Code | HTTP Status | Title / Description | Root Cause / Resolution Advice |
| :--- | :--- | :--- | :--- |
| `ERR-WO-001` | `400 Bad Request` | `WorkOrderAlreadyAssigned` | Attempted to assign a technician to a Work Order that already has an active assignment without splitting. |
| `ERR-WO-002` | `409 Conflict` | `WorkOrderClosedImmutable` | Attempted to update or modify a Work Order that is in `Closed` status. |
| `ERR-SLA-001`| `400 Bad Request` | `InvalidSlaWindow` | Target SLA completion window (`DueAtUtc`) is set to the past or exceeds tenant contract limits. |
| `ERR-SYNC-001`| `409 Conflict` | `OfflineSyncDeltaOutdated` | Mobile client attempted to sync an older item version; server delta takes precedence (`ServerWins`). |
| `ERR-SEC-001`| `403 Forbidden` | `TenantCrossQueryViolation` | Request token `tid` does not match the requested resource `TenantId`. |
