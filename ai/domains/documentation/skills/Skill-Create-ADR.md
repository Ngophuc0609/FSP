---
skill_id: SKL-DOC-001
title: Create Architecture Decision Record (ADR)
version: 1.0.0
owner: Chief Enterprise Architect
domain: documentation
capability: CAP-DOC-ADR
inputs: [Meeting Notes, Problem Statement, Trade-off Discussion]
outputs: [Formatted ADR Markdown File under ai/memory/adr/ or docs/architecture/adr/]
rules_referencing: [STD-DOC-001]
---

# Skill: Create ADR (Architecture Decision Record)

## 1. Purpose
To formally capture architectural choices, alternative solutions considered, and long-term consequences using standard ADR structuring.

## 2. Execution Steps
1.  **Extract Context:** Summarize the core problem and technical forces forcing a decision.
2.  **Evaluate Alternatives:** List 2 to 3 alternative approaches that were explored, noting pros and cons.
3.  **Formulate Decision:** Clearly articulate the chosen architectural solution and why it won.
4.  **Analyze Consequences:** State explicitly both positive trade-offs (e.g., "Fast query speed") and negative trade-offs (e.g., "Increases database storage footprint").
5.  **Assign Status & Number:** Format file name as `ADR-NNN-short-kebab-title.md` with status `Proposed` or `Approved`.
