---
id: pr_review
title: Multi-Agent Workflow - Automated Pull Request Review & Security Audit
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Exhaustive automated PR code review across Security, Performance, Architectural Boundaries, and UX.
---

# MULTI-AGENT WORKFLOW: AUTOMATED PR REVIEW & SECURITY AUDIT

This workflow executes automated gating checks on any pull request submitted to the `main` or `develop` branch.

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: Code Reviewer<br/>Security & Tenant Isolation Scan] --> B{Gate 1: Security Clean?}
    B -- Fail --> Z([Block PR & Request Changes])
    B -- Pass --> C[Step 2: Chief Architect<br/>Layer Boundary & Dependency Check]
    C --> D{Gate 2: Architecture Clean?}
    D -- Fail --> Z
    D -- Pass --> E[Step 3: Database & Performance Review]
    E --> F{Gate 3: Performance & DB Clean?}
    F -- Fail --> Z
    F -- Pass --> G([Approve PR])
```

---

## Detailed Step & Gate Instructions

### Step 1: Security & Tenant Scan (`AI Code Reviewer`)
- **Action:** Execute `review_security.md`.
- **Gate 1:** Zero tolerance for hardcoded credentials, raw SQL strings without parameters, or missing `TenantId` filters.

### Step 2: Architecture Audit (`Chief Architect`)
- **Action:** Execute `review_architecture_adr.md`.
- **Gate 2:** Verify Domain layer purity and MediatR handler structure.

### Step 3: Performance & Database Audit (`Database Architect`)
- **Action:** Execute `review_performance.md` and `review_database_schema.md`.
- **Gate 3:** Verify `.AsNoTracking()` on read queries and index coverage.
