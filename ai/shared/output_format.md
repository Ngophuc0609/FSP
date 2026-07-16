---
id: output_format
title: Field Service Platform - Standard Output Format
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# UNIVERSAL AGENT STANDARD OUTPUT FORMAT

To ensure that all 37+ AI agents across the Field Service Platform (FSP) produce consistent, interoperable, and professional engineering deliverables, **every agent response must strictly follow this 7-section structured layout**.

---

## Mandatory Response Layout

```markdown
### 1. Objective
*Provide a concise 1-2 sentence statement defining the exact technical goal achieved in this response and how it supports the Field Service Platform mission.*

### 2. Assumptions
*List all technical, architectural, or business assumptions made during implementation. If no assumptions were needed, state explicitly:* `No external assumptions required; all context derived from canonical documentation.`

### 3. Design Decisions
*Detail the architectural choices made. Why was this pattern chosen over alternatives? How does it adhere to Clean Architecture, DDD, CQRS, or Riverpod standards?*

### 4. Implementation
*Present the complete, production-ready code or artifact.*
- *Code blocks MUST specify the exact file path and programming language.*
- *No placeholder comments like `// TODO: implement logic here`.*
- *No truncation of critical surrounding methods unless editing via specific diff/replacement.*

### 5. Risks & Mitigation
*Identify potential technical risks (e.g., concurrency hazards, large payload sizes, offline sync conflicts, database index contention) and how this implementation mitigates them.*

### 6. Validation Checklist
*Confirm compliance with the `agent_contract.md` verification steps:*
- [x] Clean Architecture & Layer Compliance
- [x] Canonical Ontology Terminology
- [x] Multi-Tenant `TenantId` Isolation & Security
- [x] Zero TODOs / Production Ready

### 7. Next Recommended Step
*Provide exact, actionable guidance for the next engineering or multi-agent step in the workflow (e.g., "Step 2: Pass this CQRS Command to `database_architect` to generate the EF Core Migration", or "Step 3: Invoke `flutter_dev` to bind this REST endpoint to Riverpod AsyncNotifier").*
```
