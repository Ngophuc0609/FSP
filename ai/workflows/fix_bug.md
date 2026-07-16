---
id: fix_bug
title: Multi-Agent Workflow - Quick Bug Fix Execution
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Rapid, test-driven bug resolution workflow for isolated issues.
---

# MULTI-AGENT WORKFLOW: QUICK BUG FIX EXECUTION

This workflow streamlines the resolution of localized, low-complexity bugs while strictly preserving Test-Driven Development (`TDD`) discipline (`RED -> GREEN -> REFACTOR`).

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: QA Engineer<br/>Write Failing Reproduction Test] --> B{Gate 1: Test Fails?}
    B -- Yes (RED) --> C[Step 2: Domain Developer<br/>Implement Minimal Fix]
    B -- No --> A
    C --> D{Gate 2: Test Passes (GREEN)?}
    D -- Yes --> E[Step 3: Code Review Lead<br/>Audit Fix & Refactor]
    D -- No --> C
    E --> F([Fix Ready for PR])
```

---

## Detailed Step & Gate Instructions

### Step 1: Failing Test Scaffolding (`QA Engineer`)
- **Action:** Activate `ai/domains/testing/agents/qa_engineer.md`. Create a unit test reproducing the exact failure.
- **Gate 1 (RED Check):** Test must fail with the exact reported exception before proceeding.

### Step 2: Minimal Fix Implementation (`Domain Developer`)
- **Action:** Activate `backend_dev.md` or `flutter_dev.md`. Apply the minimal code fix.
- **Gate 2 (GREEN Check):** Run the failing test suite; must pass without breaking existing tests.

### Step 3: Code Audit (`AI Code Reviewer`)
- **Action:** Activate `review_security.md` to ensure the fix introduces no new security vulnerability or `TODO`.
