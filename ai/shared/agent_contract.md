---
id: agent_contract
title: Field Service Platform - Universal Agent Contract
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# UNIVERSAL AGENT CONTRACT (MANDATORY PRE-OUTPUT VERIFICATION)

Every AI Agent, before generating any final code, documentation, or architecture blueprint, **MUST perform the following internal verification check**.

If any check fails or required context is missing, **the agent MUST stop and request clarification or explicitly document the assumption** instead of guessing.

---

## Pre-Output Verification Checklist

Before emitting final responses, verify:

```text
[ ] ✓ 1. Project Vision & Mission
         - Does this output directly serve the Field Service Platform (FSP) enterprise requirements?
         - Does it avoid hacky prototypes, demo placeholders, or TODO shortcuts?

[ ] ✓ 2. Business Rules & Ontology
         - Are we using canonical terms exactly as defined in ai/ontology/ (Work Order, Technician, Asset, etc.)?
         - Does this implementation respect existing business rules without inventing unauthorized formulas?

[ ] ✓ 3. Clean Architecture & Layer Compliance
         - Are dependencies pointing strictly inward toward the Domain?
         - Is business logic completely absent from API Controllers, UI Widgets, or Database Triggers?

[ ] ✓ 4. Naming Conventions & Folder Standards
         - Does this follow PascalCase (.NET), snake_case (Dart/Flutter files), and kebab-case (URLs)?
         - Is the file placed exactly inside the correct domain basket (`src/<layer>/<domain>/...`)?

[ ] ✓ 5. Coding Standards & Best Practices
         - Are async/await patterns used correctly without `.Result` or `.Wait()` deadlocks?
         - Are inputs validated using FluentValidation (.NET) or explicit form validators (Flutter)?

[ ] ✓ 6. Enterprise Security & Multi-Tenancy
         - Does every query and command explicitly respect `TenantId` isolation?
         - Are endpoints protected with authorization attributes (`[Authorize(Policy = "...")]`)?
         - Are SQL queries parameterized via ORM without string concatenation vulnerabilities?

[ ] ✓ 7. Performance & Scalability Rules
         - Are database queries using `.AsNoTracking()` for read-only CQRS queries?
         - Are mobile lists using `ListView.builder` / pagination (`infinite scroll`) instead of loading all rows?
         - Is N+1 query problem prevented via explicit `.Include()` or split queries?

[ ] ✓ 8. Documentation & Impact Traceability
         - Have comments/docstrings been added for complex domain calculations?
         - Does this change require updating an ADR, OpenAPI spec, or migration script?
```

### Enforcement Rule
When producing your final output using `output_format.md`, you MUST explicitly include Section 6 (`Validation Checklist`) confirming that this contract has been fulfilled.
