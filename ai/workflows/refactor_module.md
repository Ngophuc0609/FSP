---
id: refactor_module
title: Multi-Agent Workflow - Clean Architecture Refactoring & Technical Debt Cleanup
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Safe, systematic refactoring workflow to eliminate code debt while preserving domain invariants and zero regression.
---

# MULTI-AGENT WORKFLOW: CLEAN ARCHITECTURE REFACTORING

This workflow coordinates Chief Architect, Code Reviewer, Backend, Flutter, and QA Personas to systematically restructure legacy or degraded modules back into pristine Clean Architecture adherence without breaking functional behavior.

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: Automated Code Reviewer<br/>Scan & Identify Anti-Patterns] --> B[Step 2: Chief Architect<br/>Define Refactoring Blueprint & Graph Assessment]
    B --> C[Step 3: QA Automation Lead<br/>Baseline Test Harness Verification]
    C --> D{Gate 1: Baseline 100% Pass?}
    D -- No --> E[Stop & Report Broken Baseline]
    D -- Yes --> F[Step 4: Domain Developer<br/>Execute Strangler/Refactor Increments]
    F --> G{Gate 2: Post-Refactor Test Pass & Clean Boundary Audit}
    G -- Pass --> H[Step 5: Emit Clean Artifact & Update Graph]
    G -- Fail --> F
```

---

## Detailed Step & Gate Instructions

### Step 1: Codebase Audit & Debt Identification (`AI Code Review Lead`)
- **Action:** Activate `ai/domains/architecture/agents/ai_reviewer.md`. Scan target files or modules against `ai/standards/ddd_standard.md`, `naming_standard.md`, and domain rules.
- **Output:** Debt Inventory table listing layer boundary violations, fat controllers, raw SQL queries without `TenantId`, or tightly coupled UI widgets.

### Step 2: Refactoring Blueprint & Impact Assessment (`Chief Architect`)
- **Action:** Activate `ai/domains/architecture/agents/chief_architect.md`. Consult `ai/knowledge_graph/master_graph.md` to evaluate impact.
- **Output:** Refactoring Blueprint (`docs/architecture/refactoring_plan.md`) outlining step-by-step decoupling increments using Strangler Fig or CQRS segregation patterns.

### Step 3: Baseline Test Harness Check (`QA Automation Lead`)
- **Action:** Activate `ai/domains/testing/agents/qa_engineer.md`. Run all existing unit and integration tests for the target module.
- **Gate 1 (Baseline Integrity Check):**
  - Must achieve 100% test pass on existing suites before refactoring begins.
  - *If Gate 1 Fails:* Stop workflow and require bug fix before refactoring (`debug_incident.md`).

### Step 4: Incremental Transformation (`Principal Backend / Flutter Dev`)
- **Action:** Activate `backend_dev.md` or `flutter_dev.md`. Execute the refactoring increments:
  1. Extract interfaces and pure domain entities.
  2. Migrate business logic from Controller/Widget into MediatR Handlers or Riverpod Notifiers.
  3. Apply `FluentValidation` and `Result<T>` pattern.

### Step 5: Verification Gate & Graph Update (`Code Reviewer + Chief Architect`)
- **Gate 2 (Zero-Regression & Layer Audit):**
  - Re-run all QA test suites (Must pass 100%).
  - Verify layer boundaries using static check rules (`RULE-DDD-001`).
- **Output:** Update `ai/knowledge_graph/master_graph.md` and record structural improvements.
