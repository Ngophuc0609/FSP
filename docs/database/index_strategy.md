---
title: Multi-Tenant Indexing Strategy & Optimization
category: database
version: 2.0.0
last_updated: 2026-07-15
---

# MULTI-TENANT INDEXING STRATEGY

## 1. The TenantId Leading Column Rule
Because every SQL read operation appends `WHERE TenantId = @tenantId` via global query filters, **`TenantId` MUST be the leading column on all non-clustered composite indexes**.

### Example High-Performance Index Definition
```sql
-- Optimal composite index for querying active Work Orders within a Tenant
CREATE NONCLUSTERED INDEX [IX_WorkOrders_TenantId_Status_Priority]
ON [dbo].[WorkOrders] ([TenantId], [Status], [Priority])
INCLUDE ([WorkOrderId], [AssetId], [DueAtUtc])
WHERE ([IsDeleted] = 0);
```

---

## 2. Filtered Soft-Delete Indexing
To prevent soft-deleted records (`IsDeleted = 1`) from bloating B-tree index structures and degrading read query speed, all non-clustered indexes MUST use a SQL Server filtered predicate: `WHERE ([IsDeleted] = 0)`.
