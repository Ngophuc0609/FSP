---
title: Database Naming Conventions & SQL Standards
category: database
version: 2.0.0
last_updated: 2026-07-15
---

# DATABASE NAMING CONVENTIONS & STANDARDS

## 1. Table & Column Naming Rules
- **Table Names:** Must be pluralized `PascalCase` nouns (`WorkOrders`, `Technicians`, `Assets`).
- **Primary Keys:** Must be named `<SingularEntityName>Id` (`WorkOrderId`, `AssetId`).
- **Foreign Keys:** Must precisely match the target primary key (`TenantId`, `AssetId`).
- **Boolean Columns:** Must start with `Is` or `Has` (`IsActive`, `IsChecked`, `HasSignature`).
- **Date/Time Columns:** Must explicitly end with `Utc` (`CreatedAtUtc`, `DueAtUtc`, `CompletedAtUtc`) and use data type `datetime2`.

---

## 2. Mandatory Audit Columns
Every entity table in SQL Server MUST include the 4 canonical audit columns:
```sql
[CreatedAtUtc] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
[CreatedBy] NVARCHAR(128) NOT NULL,
[UpdatedAtUtc] DATETIME2(7) NULL,
[UpdatedBy] NVARCHAR(128) NULL,
[IsDeleted] BIT NOT NULL DEFAULT 0
```
