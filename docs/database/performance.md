---
title: Database Performance Tuning & ORM Guidelines
category: database
version: 2.0.0
last_updated: 2026-07-15
---

# DATABASE PERFORMANCE TUNING & ORM GUIDELINES

## 1. Entity Framework Core Read-Only Rule (`AsNoTracking`)
When MediatR `IRequestHandler<TQuery, Result<T>>` executes a read-only projection (e.g., fetching a list of `WorkOrders` for the dispatch grid), **the EF Core query MUST explicitly invoke `.AsNoTracking()`**.
- **Reason:** By default, EF Core tracks instantiated entities inside `DbContext.ChangeTracker` memory to detect modifications during `SaveChanges()`. For read-only API requests, this wastes up to `40% CPU time and memory allocations`.

---

## 2. N+1 Query Loop Prevention Rule
Executing LINQ queries or database calls inside a `foreach` loop is **STRICTLY FORBIDDEN**:
```csharp
// FORBIDDEN: Causes N+1 database queries
foreach (var workOrder in workOrders) {
    var asset = await _dbContext.Assets.FirstOrDefaultAsync(a => a.AssetId == workOrder.AssetId);
}

// MANDATORY OPTIMIZED PATTERN: Single batch query / Eager loading via Include or Projection
var workOrderDtos = await _dbContext.WorkOrders
    .AsNoTracking()
    .Where(w => w.TenantId == tenantId)
    .Select(w => new WorkOrderSummaryDto(w.WorkOrderId, w.Description, w.Asset.Name))
    .ToListAsync(cancellationToken);
```
