---
title: Database Schema & Multi-Tenant Rules (Azure SQL Server)
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# DATABASE SCHEMA & MULTI-TENANT RULES (`RULE-DB-001` to `005`)

## RULE-DB-001: Mandatory TenantId & Global Query Filters
Every relational table in Azure SQL Server (except global dictionaries/lookups) MUST contain a non-nullable `TenantId` (`uniqueidentifier`) column indexed as the leading column in composite indexes. EF Core `DbContext` MUST configure global filters:
```csharp
modelBuilder.Entity<WorkOrder>().HasQueryFilter(w => w.TenantId == _tenantProvider.TenantId);
```

## RULE-DB-002: Zero-Downtime Expand-and-Contract Migrations
Never execute destructive schema drops (`DROP COLUMN`, `RENAME TABLE`) during active deployment cycles. All column additions must initially be nullable (`Expand`), followed by backfilling logic, and finally applying non-null constraints (`Contract`) across subsequent deployment windows.

## RULE-DB-003: Mandatory Audit Columns
Every table must contain the mandatory audit timestamp and tracking columns:
- `CreatedAtUtc` (`datetime2(7)`, `NOT NULL`)
- `CreatedBy` (`uniqueidentifier`, `NOT NULL`)
- `LastModifiedAtUtc` (`datetime2(7)`, `NULL`)
- `LastModifiedBy` (`uniqueidentifier`, `NULL`)
