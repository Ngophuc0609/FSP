---
title: Structured Logging Standards (Serilog & JSON Format)
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# STRUCTURED LOGGING STANDARDS (`Serilog`)

## 1. JSON Structured Log Payload Standard
All log output across production environments must be formatted as structured JSON for ingestion into ELK / Log Analytics. String concatenation inside log messages (`_logger.LogInformation("Processing order " + id);`) is **STRICTLY PROHIBITED**.

### Mandatory Structured Logging Syntax
```csharp
// OPTIMAL STRUCTURED LOGGING (Parameters enriched automatically)
_logger.LogInformation(
    "Processing Work Order {WorkOrderId} for Tenant {TenantId} assigned to {TechnicianId}",
    workOrder.WorkOrderId,
    _tenantProvider.TenantId,
    assignment.UserId
);
```

---

## 2. Log Enrichment & Sensitive Data Redaction
- Every log event must be automatically enriched with correlation ID (`TraceId`), `TenantId`, and `UserId` via `Serilog.Enrichers`.
- Sensitive personal customer data (`PasswordHash`, `JwtSecret`, `CreditCardNumber`) MUST be redacted automatically by custom logging sink destructurers.
