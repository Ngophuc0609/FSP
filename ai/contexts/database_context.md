---
id: database_context
title: Field Service Platform - Database & Schema Micro-Context
tier: 2_contexts
domain: database
version: 2.0.0
last_updated: 2026-07-15
---

# DATABASE & SCHEMA MICRO-CONTEXT (SQL SERVER & EF CORE 8)

## 1. Multi-Tenant Schema Architecture
The primary database is **Microsoft SQL Server** operating in a **Shared Database, Shared Schema with TenantId Column Partitioning** model.
- Every tenant-scoped table MUST include:
  - `TenantId` (`uniqueidentifier`, NOT NULL)
  - `Id` (`uniqueidentifier`, NOT NULL, Primary Key)
  - `CreatedAtUtc` (`datetime2`, NOT NULL)
  - `CreatedBy` (`nvarchar(256)`, NOT NULL)
  - `UpdatedAtUtc` (`datetime2`, NULL)
  - `UpdatedBy` (`nvarchar(256)`, NULL)
  - `IsDeleted` (`bit`, NOT NULL, Default 0 - Soft Delete)

---

## 2. Indexing Strategy & Performance Rules
- **Composite Clustered/Non-Clustered Indexes:** Because 99.9% of queries are scoped to a single tenant, `TenantId` MUST be the leading column in almost all high-traffic indexes:
  ```sql
  CREATE NONCLUSTERED INDEX [IX_WorkOrders_TenantId_Status_ScheduledStart] 
  ON [dbo].[WorkOrders] ([TenantId], [Status], [ScheduledStart]) 
  INCLUDE ([Title], [AssignedTechnicianId]);
  ```
- **Soft Delete Filtered Indexes:** To ensure fast lookups without scanning deleted records, indexes should be filtered:
  ```sql
  WHERE [IsDeleted] = 0
  ```

---

## 3. EF Core Migrations & Zero-Downtime Deployment
- **No destructive migrations in single steps:** Never drop a table or column directly in a production migration if the application code is still reading from it.
- **2-Phase Rename/Drop Pattern:**
  1. Phase 1: Add new column (nullable), write to both old and new columns, backfill data.
  2. Phase 2: Deploy app that reads from new column.
  3. Phase 3: Drop old column in a subsequent release.
- All EF Core entity configurations must reside in separate `IEntityTypeConfiguration<T>` classes inside `src/Infrastructure/Persistence/Configurations/`. Never clutter `DbContext.OnModelCreating` with inline configurations.
