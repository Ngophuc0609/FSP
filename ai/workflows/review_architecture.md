---
id: review_architecture
title: Multi-Agent Workflow - Architecture & Layer Boundary Review
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates Chief Architect to review structural boundaries and emit ADRs.
---

# MULTI-AGENT WORKFLOW: ARCHITECTURE REVIEW

This workflow delegates directly to `ai/prompts/review_architecture_adr.md` to enforce Clean Architecture invariants across all code changes.

---

## Workflow Verification Points
1. **Layer Independence:** `FSP.Domain` must not reference any UI, API, or EF Core framework package.
2. **CQRS Isolation:** Commands must encapsulate single aggregate root state mutations; queries must use `AsNoTracking()`.
3. **ADR Requirement:** Any new cross-cutting concern or external dependency must produce a documented `ADR` in `ai/memory/adr/`.
