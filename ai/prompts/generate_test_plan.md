---
id: generate_test_plan
title: Prompt Wrapper - Generate Comprehensive Test Plan & QA Strategy
tier: 4_prompt_wrappers
domain: testing
target_agent: ai/domains/testing/agents/qa_engineer.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: GENERATE COMPREHENSIVE TEST PLAN & QA STRATEGY

This prompt wrapper coordinates the QA & Test Automation Lead persona to produce exhaustive Test Plans (`docs/testing/test_plan.md`) and scaffold unit, integration, and E2E test cases.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read: `project_charter.md`, `project_objective.md`, `universal_rules.md`, `design_principles.md`, `glossary.md`.

### Step 2: Load Domain Micro-Context
Read: `ai/contexts/testing_context.md` and `ai/contexts/business_context.md`.

### Step 3: Execute Target Agent Persona
Activate `ai/domains/testing/agents/qa_engineer.md`. Given the target feature or module, generate:
1. Test Plan Overview & Scope (Unit vs. Integration vs. Widget vs. E2E).
2. Test Environment & Mocking Strategy (`Testcontainers` for SQL/Redis, `NSubstitute` for .NET, `mocktail` for Dart).
3. Test Matrix: Happy Path, Negative Edge Cases, Boundary Values, and Multi-Tenant Isolation verification (`TenantId` query filters).
4. Concrete, production-grade test code adhering to `AAA` pattern (`Arrange-Act-Assert`).

### Step 4: Output Final Artifact
Emit the verified test suite adhering to `ai/shared/output_format.md`.
