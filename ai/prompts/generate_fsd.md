---
id: generate_fsd
title: Prompt Wrapper - Generate Functional Specification Document (FSD)
tier: 4_prompt_wrappers
domain: business
target_agent: ai/domains/business/agents/business_analyst.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: GENERATE FUNCTIONAL SPECIFICATION DOCUMENT (FSD)

This prompt wrapper coordinates the Lead Business Analyst and Chief Enterprise Architect personas to translate PRDs into technical Functional Specifications (`docs/business/fsd.md`).

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA & Micro-Contexts
Read: `project_charter.md`, `project_objective.md`, `universal_rules.md`, `glossary.md`, `business_context.md`, `architecture_context.md`.

### Step 2: Load Existing PRD
Cross-reference `docs/business/prd.md` and `acceptance_criteria.md`.

### Step 3: Execute Target Agent Personas
Activate `ai/domains/business/agents/business_analyst.md` and `chief_architect.md`. Generate an exhaustive FSD specifying:
1. Detailed System Behavior & State Machines (e.g., `WorkOrderStatus` transitions).
2. Data Exchange Models & Sequence Interactions.
3. Validation Rules & Exception Handling Scenarios.
4. RBAC / ABAC Security Matrix (`functional_matrix.md`).
5. Offline Sync Delta & Conflict Resolution Rules.

### Step 4: Output Final Artifact
Emit the verified FSD adhering to `ai/shared/output_format.md`.
