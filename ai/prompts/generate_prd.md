---
id: generate_prd
title: Prompt Wrapper - Generate Product Requirement Document (PRD)
tier: 4_prompt_wrappers
domain: business
target_agent: ai/domains/business/agents/business_analyst.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: GENERATE PRODUCT REQUIREMENT DOCUMENT (PRD)

This prompt wrapper coordinates the execution of the Lead Business Analyst persona to transform stakeholder concepts into exhaustive, quantitative Product Requirement Documents (`docs/business/prd.md`).

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read: `project_charter.md`, `project_objective.md`, `universal_rules.md`, `design_principles.md`, `glossary.md`.

### Step 2: Load Domain Micro-Context
Read: `ai/contexts/business_context.md` and `ai/contexts/product_context.md`.

### Step 3: Execute Target Agent Persona
Activate `ai/domains/business/agents/business_analyst.md`. Generate a comprehensive PRD containing:
1. Executive Summary & Problem Statement.
2. Target User Personas & Value Proposition.
3. Functional Scope (In-Scope vs. Out-of-Scope).
4. Detailed User Journeys & Wireframe Descriptions.
5. Quantitative Non-Functional Requirements (SLA thresholds, API response latency, offline capability).

### Step 4: Audit against Ontology
Verify every operational term against `ai/ontology/business.md` (`Work Order`, `Technician`, `Assignment`, `Asset`).

### Step 5: Output Final Artifact
Emit the finalized PRD adhering to `ai/shared/output_format.md`.
