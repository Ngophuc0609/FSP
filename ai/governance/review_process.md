---
policy_id: GOV-REV-001
title: AI & Human Code Review Process
version: 1.0.0
owner: Principal Software Engineer
last_updated: 2026-07-15
---

# AI & Human Code Review Process

## 1. Multi-Tier Review Pipeline
Every pull request submitted to `develop` or `main` must pass through a two-tier verification process:

```text
[ Developer / AI Agent creates PR ]
                ↓
[ Tier 1: Automated AI Review Gate ] (Enforces Rules, Standards & Impact Traceability)
                ↓ (Pass)
[ Tier 2: Human Architect Review ] (Verifies Business Logic & Structural Harmony)
                ↓ (Approve)
      [ Merge to Branch ]
```

## 2. Tier 1: AI Review Gate Responsibilities (`ai_reviewer` Persona)
Before a human reviews a pull request, the automated AI Reviewer must verify:
- **Rule Compliance:** Check diff against applicable rules in `ai/domains/<domain>/rules/`.
- **Standard Adherence:** Verify naming conventions, clean architecture dependencies, and test coverage.
- **Knowledge Graph Traceability:** Confirm whether any modified schema or API causes breaking changes across the relationship chain (`ai/knowledge_graph/`).
- **Zero Secrets & Security:** Ensure no API keys, credentials, or PII are exposed in the diff.

## 3. Tier 2: Human Architect Responsibilities
- Evaluate overall design elegance and long-term maintainability.
- Verify that new business rules strictly match customer requirements and PRDs.
- Sign off on any updates to `ai/constitution/`, `ai/ontology/`, or `ai/standards/`.
