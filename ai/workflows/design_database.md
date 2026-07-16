---
id: design_database
title: Multi-Agent Workflow - Database Schema Design & Migration Planning
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates Database Architect and Backend Personas to design multi-tenant schemas and zero-downtime EF Core migrations.
---

# MULTI-AGENT WORKFLOW: DATABASE SCHEMA & MIGRATION DESIGN

This workflow coordinates Database Architect and Principal .NET Backend Developer to design, optimize, and verify database tables, indexes, and EF Core entity configurations (`IEntityTypeConfiguration<T>`).

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: Database Architect<br/>Formulate Schema & ERD] --> B{Gate 1: Multi-Tenant & Naming Audit}
    B -- Pass --> C[Step 2: Principal Backend Dev<br/>Scaffold EF Core Entity Configuration]
    B -- Fail --> A
    C --> D[Step 3: Database Architect<br/>Review SQL Script & Index Strategy]
    D --> E{Gate 2: Zero-Downtime Migration Audit}
    E -- Pass --> F([Ready for DB Migration Apply])
    E -- Fail --> C
```

---

## Detailed Step & Gate Instructions

### Step 1: Schema Formulation (`Database Architect`)
- **Action:** Activate `ai/domains/database/agents/db_architect.md`. Design table structure and update `docs/database/erd.md`.
- **Gate 1 (Multi-Tenant & Naming Check):**
  - Verify every table includes `TenantId` (`uniqueidentifier`) and audit columns (`CreatedAtUtc`, `CreatedBy`).
  - Verify table names use `PascalCase` pluralization (`WorkOrders`, `Technicians`).
  - *If Gate 1 Fails:* Return to Step 1.

### Step 2: EF Core Configuration (`Principal .NET Backend Dev`)
- **Action:** Activate `ai/domains/backend/agents/backend_dev.md`. Implement `IEntityTypeConfiguration<TEntity>` with explicit column precisions and global query filters (`HasQueryFilter(e => e.TenantId == _tenantProvider.TenantId)`).

### Step 3: Migration Audit & Index Check (`Database Architect`)
- **Action:** Activate `ai_prompts/review_database_schema.md`.
- **Gate 2 (Zero-Downtime Migration Audit):**
  - Verify migration script does not drop populated columns directly or lock tables without online index build flags (`WITH (ONLINE = ON)`).
