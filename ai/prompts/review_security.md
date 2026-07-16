---
id: review_security
title: Prompt Wrapper - Review Security & Multi-Tenant Isolation
tier: 4_prompt_wrappers
domain: architecture
target_agent: ai/domains/architecture/agents/ai_reviewer.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: REVIEW SECURITY & MULTI-TENANT ISOLATION

This prompt wrapper coordinates the Automated Code Reviewer and Chief Enterprise Architect personas to perform rigorous security audits on target files or pull requests.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read: `project_charter.md`, `universal_rules.md`, `design_principles.md`.

### Step 2: Load Domain Micro-Context
Read: `ai/contexts/api_context.md`, `ai/contexts/database_context.md`.

### Step 3: Execute Target Agent Persona
Activate `ai/domains/architecture/agents/ai_reviewer.md` focusing strictly on security rules (`RULE-SEC-001`):
1. **Tenant Isolation Check:** Verify that every database query invokes `TenantId` global filters or explicit where clauses.
2. **SQL Injection Check:** Verify all EF Core queries use parameters (`FromSqlInterpolated` or LINQ); block `FromSqlRaw` string formatting.
3. **Authorization Check:** Verify every controller endpoint declares `[Authorize(Policy = "...")]`.
4. **Secret Scan:** Check for hardcoded API keys, JWT secrets, or connection strings.
5. **Input Sanitization:** Verify `FluentValidation` validates length, format, and range before processing commands.

### Step 4: Output Final Artifact
Emit the audit finding table and drop-in fixes adhering to `ai/shared/output_format.md`.
