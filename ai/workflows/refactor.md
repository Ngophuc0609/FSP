---
id: refactor
title: Multi-Agent Workflow - Standard Code Refactoring (Alias)
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Lightweight alias for refactor_module.md coordinating safe module refactoring.
---

# MULTI-AGENT WORKFLOW: STANDARD REFACTORING

This workflow is the standard entry point for code refactoring and technical debt reduction, delegating directly to the primary Clean Architecture refactoring pipeline (`ai/workflows/refactor_module.md`).

---

## Quick Execution Steps
1. **Pre-Check:** Ensure all existing unit and integration tests pass (`baseline check`).
2. **Execute:** Delegate execution to `ai/workflows/refactor_module.md`.
3. **Verify:** Re-run test harness to guarantee zero functional regression.
