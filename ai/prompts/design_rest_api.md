---
id: design_rest_api
title: Prompt Wrapper - Design REST API & OpenAPI Contract
tier: 4_prompt_wrappers
domain: api
target_agent: ai/domains/api/agents/api_designer.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: DESIGN REST API & OPENAPI CONTRACT

This prompt wrapper coordinates the execution of the API & Integration Designer persona to produce rigorous RESTful API specifications, OpenAPI 3.0/Swagger contracts, Request/Response DTOs, and RFC 7807 error formats.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read: `project_charter.md`, `project_objective.md`, `universal_rules.md`, `design_principles.md`, `glossary.md`.

### Step 2: Load Domain Micro-Context
Read: `ai/contexts/api_context.md` and `ai/contexts/backend_context.md`.

### Step 3: Load Relevant Standards
Read: `ai/standards/rest_standard.md`.

### Step 4: Execute Target Agent Persona
Activate `ai/domains/api/agents/api_designer.md`. Pass the feature specification (`PRD`/`FSD`) and generate:
1. Plural noun, `kebab-case` URL endpoint definitions (`/api/v1/...`).
2. Complete Request/Response DTO schemas with data types and validation rules.
3. Explicit authorization policy annotations (`[Authorize(Policy = "...")]`).
4. RFC 7807 `ProblemDetails` error response payloads for every anticipated failure scenario (400, 401, 403, 404, 409).
5. Idempotency (`X-Idempotency-Key`) rules for mutating POST operations.

### Step 5: Review & Audit Result
Execute `ai/domains/architecture/agents/ai_reviewer.md` to verify no domain entities are directly exposed and route conventions adhere to REST standards.

### Step 6: Output Final Artifact
Emit the verified API specification adhering to `ai/shared/output_format.md`.
