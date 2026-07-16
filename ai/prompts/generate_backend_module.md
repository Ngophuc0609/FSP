---
id: generate_backend_module
title: Prompt Wrapper - Generate .NET Backend Module
tier: 4_prompt_wrappers
domain: backend
target_agent: ai/domains/backend/agents/backend_dev.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: GENERATE .NET BACKEND MODULE

This prompt wrapper coordinates the execution of the Principal .NET Backend Developer persona to build production-grade C# Clean Architecture modules (`Domain`, `Application`, `Infrastructure`, `Api`).

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read and internalize:
- `ai/shared/project_charter.md`
- `ai/shared/project_objective.md`
- `ai/shared/universal_rules.md`
- `ai/shared/design_principles.md`
- `ai/shared/glossary.md`

### Step 2: Load Domain Micro-Context
Read and internalize:
- `ai/contexts/backend_context.md`
- `ai/contexts/database_context.md`

### Step 3: Load Relevant Standards
Read and internalize:
- `ai/standards/ddd_standard.md`
- `ai/standards/rest_standard.md`
- `ai/standards/naming_standard.md`

### Step 4: Load Domain Rules & Knowledge Graph
Check:
- `ai/knowledge_graph/master_graph.md` (to verify downstream dependencies: DB Schema -> API -> UI)
- `ai/domains/backend/rules/` (if any specific backend domain invariants exist)

### Step 5: Execute Target Agent Persona
Activate `ai/domains/backend/agents/backend_dev.md`. Pass the user's specific feature request and instruct the agent to scaffold:
1. Pure C# Domain Entity (`BaseTenantEntity`), Value Objects, and Domain Events.
2. CQRS `Command` / `Query` records and MediatR `IRequestHandler<T, Result<R>>`.
3. `FluentValidation` `AbstractValidator<T>` rules.
4. EF Core `IRepository<T>` interface and `AsNoTracking()` implementation.
5. ASP.NET Core Controller or Minimal API endpoint returning RFC 7807 `ProblemDetails`.

### Step 6: Review & Audit Result
Execute `ai/domains/architecture/agents/ai_reviewer.md` to verify layer boundaries, `TenantId` isolation, parameterization, and zero `TODO` placeholders.

### Step 7: Output Final Artifact
Emit the verified code using the mandatory 7-section layout defined in `ai/shared/output_format.md` (`Objective`, `Assumptions`, `Design Decisions`, `Implementation`, `Risks`, `Validation Checklist`, `Next Recommended Step`).
