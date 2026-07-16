---
id: review_architecture_adr
title: Prompt Wrapper - Review Architecture & Architectural Decision Records (ADR)
tier: 4_prompt_wrappers
domain: architecture
target_agent: ai/domains/architecture/agents/chief_architect.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: REVIEW ARCHITECTURE & ADR

This prompt wrapper coordinates the Chief Enterprise Architect persona to audit structural changes against `clean_architecture.md` and generate formal Architectural Decision Records (`ADRs`).

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA & Micro-Contexts
Read: `project_charter.md`, `project_objective.md`, `universal_rules.md`, `architecture_context.md`.

### Step 2: Load Architectural Graph & Standards
Read: `ai/knowledge_graph/master_graph.md` and `ai/standards/ddd_standard.md`.

### Step 3: Execute Target Agent Persona
Activate `chief_architect.md` to evaluate the architectural proposal or PR diff:
1. **Inward Dependency Verification:** Verify Domain layer has 0 external dependencies and Application depends only on Domain.
2. **CQRS & Bounded Context Audit:** Ensure commands mutate state in only one aggregate root and domain events decouple external modules.
3. **ADR Generation:** If the change introduces a new technology, pattern, or significant tradeoff, generate a formal ADR adhering to `ai/templates/adr_template.md` (`Context`, `Decision`, `Alternatives Considered`, `Consequences`).

### Step 4: Output Final Artifact
Emit the architectural review verdict and/or ADR document adhering to `ai/shared/output_format.md`.
