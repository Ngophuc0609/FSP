---
title: Zero-Downtime Database Migration Strategy
category: database
version: 2.0.0
last_updated: 2026-07-15
---

# ZERO-DOWNTIME DATABASE MIGRATION STRATEGY

## 1. The Expand and Contract Strategy (Parallel Runs)
To maintain `99.9%` API uptime during schema deployments, direct destructive mutations (`DROP COLUMN`, `RENAME COLUMN`) are **STRICTLY PROHIBITED** inside a single EF Core migration.

### Step-by-Step Expand and Contract Phase
1. **Phase 1 (Expand):** Add the new column (`NewColumn`) as nullable (`NULL`) without removing the old column (`OldColumn`). Deploy the application code that writes to both columns.
2. **Phase 2 (Migrate Data):** Execute a background SQL batch job to backfill existing rows from `OldColumn` into `NewColumn`.
3. **Phase 3 (Switch Read):** Deploy updated application code that reads exclusively from `NewColumn`.
4. **Phase 4 (Contract):** In the next release window (`+2 weeks`), safely drop `OldColumn` via a cleanup migration.

---

## 2. Online Index Execution Rules
Whenever adding an index to a heavily queried table (`WorkOrders`, `SyncQueueTable`) in production SQL Server, migration scripts MUST append `WITH (ONLINE = ON)` to avoid acquiring table-level schema locks that block incoming MediatR API requests.
