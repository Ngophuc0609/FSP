---
title: Strategic & Operational Goals - Field Service Platform (FSP)
category: product
version: 2.0.0
last_updated: 2026-07-15
---

# STRATEGIC & OPERATIONAL GOALS

## Quantitative Key Performance Indicators (KPIs)

| Metric Category | Target KPI | Baseline vs. Target | Measurement Mechanism |
| :--- | :--- | :--- | :--- |
| **First-Time Fix Rate (FTFR)** | `>= 88%` | Industry average (65%) -> Target (88%) | Tracked via completed `WorkOrders` without follow-up re-assignments within 30 days. |
| **Mean Time To Resolution (MTTR)** | `< 4 hours` (Critical SLAs) | 12 hours -> `< 4 hours` | Timestamp delta from `WorkOrder.CreatedAtUtc` to `WorkOrder.CompletedAtUtc`. |
| **Offline Sync Reliability** | `99.999%` | Zero data loss during network disconnection | Audited via sync queue delta hashes (`IsSynced = 1` verification). |
| **API Latency (P95)** | `< 200ms` | For all read queries across MediatR handlers | Tracked via Application Insights and OpenTelemetry request duration. |
| **Mobile App Crash-Free Rate** | `>= 99.8%` | Across iOS and Android field devices | Tracked via Firebase Crashlytics on Flutter client. |

---

## Technical Architecture Goals
1. **Zero Coupling:** `FSP.Domain` must never reference application primitives, EF Core, or web libraries (`100% Pure C# Domain`).
2. **100% CQRS Segregation:** All write actions must execute through `IRequestHandler<TCommand, Result<T>>` and reads via `IRequestHandler<TQuery, Result<T>>` with `.AsNoTracking()`.
3. **Multi-Tenant Zero-Trust Isolation:** Every database operation must automatically append `WHERE TenantId = @tenantId` via global filters.
