---
id: generate_brd
title: Prompt Wrapper - Generate Business Requirement Document (BRD)
tier: 4_prompt_wrappers
domain: business
target_agent: ai/domains/business/agents/business_analyst.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: GENERATE BUSINESS REQUIREMENT DOCUMENT (BRD)

This prompt wrapper coordinates the Lead Business Analyst persona to formulate executive-level Business Requirement Documents (`docs/business/brd.md`) covering ROI, operational metrics, SLA regulations, and cost justifications.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read: `project_charter.md`, `project_objective.md`, `universal_rules.md`, `glossary.md`.

### Step 2: Load Domain Micro-Context
Read: `ai/contexts/business_context.md` and `ai/contexts/product_context.md`.

### Step 3: Execute Target Agent Persona
Activate `ai/domains/business/agents/business_analyst.md`. Generate a structured BRD containing:
1. Business Objectives & Strategic Alignment.
2. Current State Pain Points (Dispatch bottlenecks, offline data loss, billing delays).
3. Target Financial & Operational KPIs (`MTTR`, `First-Time Fix Rate`, `Technician Utilization`).
4. Regulatory & Compliance Requirements (Safety inspections, GDPR data retention).
5. Stakeholder Matrix & Cost-Benefit Analysis.

### Step 4: Output Final Artifact
Emit the verified BRD adhering to `ai/shared/output_format.md`.
