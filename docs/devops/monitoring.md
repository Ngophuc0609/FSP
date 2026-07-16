---
title: Observability & Application Monitoring (OpenTelemetry / App Insights)
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# OBSERVABILITY & MONITORING STANDARD (`OpenTelemetry`)

## 1. Distributed Tracing Architecture
`FSP` integrates **OpenTelemetry** with **Azure Application Insights / Prometheus + Grafana** to provide end-to-end distributed tracing across API controllers, MediatR CQRS handlers, and SQL database execution strategies.

---

## 2. Mandatory Metric Tracking
- **`fsp.api.request.duration`:** Histogram of endpoint latency (`P50`, `P95`, `P99`).
- **`fsp.sync.delta.batch_size`:** Counter tracking number of items processed during mobile offline synchronization.
- **`fsp.sla.breach.count`:** Alert gauge triggered when an active `WorkOrder` breaches its `DueAtUtc` target window.
