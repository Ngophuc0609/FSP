---
id: review_database_schema
title: Prompt Wrapper - Review Database Schema & EF Core Migrations
tier: 4_prompt_wrappers
domain: database
target_agent: ai/domains/database/agents/db_architect.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: REVIEW DATABASE SCHEMA & EF CORE MIGRATIONS

This prompt wrapper coordinates the Database & Schema Architect persona to inspect SQL Server tables, indexes, entity configurations, and EF Core migration scripts before deployment.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA & Micro-Contexts
Read: `project_charter.md`, `universal_rules.md`, `database_context.md`.

### Step 2: Load Existing ERD & Standards
Read: `docs/database/erd.md`, `ai/standards/naming_standard.md`.

### Step 3: Execute Target Agent Persona
Activate `db_architect.md` to review the proposed database change:
1. **Multi-Tenant Partitioning Audit:** Check every table for `TenantId` (`uniqueidentifier`), primary keys, and auditing columns (`CreatedAtUtc`, `CreatedBy`).
2. **Zero-Downtime Migration Check:** Verify that EF Core migrations do not drop columns or tables directly while previous code is deployed.
3. **Index Structure Verification:** Ensure `TenantId` is the leading column on clustered/non-clustered indexes and filtered indexes (`WHERE IsDeleted = 0`) are present.
4. **Data Type Precision Check:** Verify explicit column lengths (`nvarchar(256)`) and decimal precisions (`decimal(18,2)` for financial fields).

### Step 4: Output Final Artifact
Emit the DBA review report and optimized SQL/EF configuration code adhering to `ai/shared/output_format.md`.
