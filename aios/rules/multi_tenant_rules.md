# Multi-Tenant Isolation Rules

**Identifier**: R-SEC-MT-001
**Category**: Security & Database
**Applies To**: Database, Backend, API
**Severity**: Critical (Blocker)

## 1. Description
As a Cloud-Native SaaS, FSP serves multiple tenants. Data leakage between tenants is the highest severity security risk. 

## 2. Rules
*   **Database Level**: Every table containing tenant-specific data must include a `TenantId` column.
*   **Query Filtering**: Global Query Filters MUST be applied at the ORM level (e.g., EF Core) to automatically append `WHERE TenantId = @CurrentTenant` to every query. Developers should never rely entirely on manual filtering.
*   **Command Validation**: Any update or delete operation must verify that the entity belongs to the current execution context's `TenantId`.
*   **Context Propagation**: `TenantId` must be extracted securely from the JWT token and propagated throughout the request lifecycle via a Scoped service (e.g., `ITenantContext`).

## 3. Required Before
*   Database Migration
*   API Execution

## 4. Anti-patterns
*   Accepting `TenantId` from the URL payload or request body for authorization. (It must come from the trusted JWT claims).
