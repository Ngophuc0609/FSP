---
id: universal_rules
title: Field Service Platform - Universal Rules
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# UNIVERSAL BEHAVIORAL & CODING RULES

All AI Agents operating within the Field Service Platform (FSP) repository **must strictly obey** these universal rules without exception.

---

## Rule 1: Always Read Project Context First
Before writing a single line of code, modifying an existing file, or generating an architectural design, the agent **MUST read and internalize**:
1. This `project_charter.md` and `universal_rules.md`.
2. The specific domain context (`ai/contexts/<domain>_context.md`).
3. The relevant standards (`ai/standards/<domain>_standard.md`).
4. Any existing domain rules inside `ai/domains/<domain>/rules/`.

---

## Rule 2: Always Preserve Consistency
- Ensure that every newly introduced class, method, variable, or database table follows the established patterns across the codebase.
- Never introduce competing libraries or frameworks if an established standard already exists (e.g., do not introduce `Newtonsoft.Json` when `.NET 8 System.Text.Json` is our standard; do not introduce `Provider` when `Riverpod` is our Flutter standard).

---

## Rule 3: Never Invent Business Rules
- AI agents are strict implementers and technical advisors, **not speculative business inventors**.
- Do not make assumptions about pricing formulas, SLA penalty calculations, inventory consumption rules, or approval hierarchies unless explicitly documented in `docs/business/` or `ai/ontology/`.

---

## Rule 4: Handling Missing Information & Ambiguity
If critical information, API contracts, database columns, or business criteria are missing from the prompt or project documentation:
1. **Explain Assumptions Explicitly:** Clearly state what assumptions are being made to proceed.
2. **Mark Them Clearly:** Prefix assumptions with `[ASSUMPTION]` or highlight them in the output summary.
3. **Do Not Fabricate APIs:** Never invent fake backend endpoints when building mobile/web UI. Check existing controllers or request/define an explicit OpenAPI/REST specification first.
4. **Do Not Fabricate Database Schema:** Never invent foreign keys or tables without cross-referencing `ai/ontology/` and `docs/database/erd.md`.

---

## Rule 5: Always Reuse Existing Terminology & Standards
- Strictly adhere to the canonical terminology defined in `ai/ontology/` (`Work Order`, `Assignment`, `Technician`, `Asset`, `Inspection`, `Tenant`).
- Do not invent synonyms (e.g., do not use `Job` or `TaskCard` when `Work Order` is our canonical term; do not use `Worker` when `Technician` is established).

---

## Rule 6: Naming & Structural Enforcement
- **C# / .NET:** `PascalCase` for classes, interfaces (`IInterfaceName`), records, properties, and public methods. `camelCase` for local variables and parameters. `_camelCase` for private readonly fields.
- **Dart / Flutter:** `snake_case.dart` for file names and directories. `PascalCase` for classes, widgets, and enums. `camelCase` for variables, functions, and parameters.
- **SQL Server:** `PascalCase` or `snake_case` strictly adhering to `ai/standards/naming_standard.md`. `TenantId` must be the first column in composite indexes for multi-tenant tables.
- **REST APIs:** `kebab-case` for URL paths (`/api/v1/work-orders/{id}/assign`). Plural nouns for resources.

---

## Rule 7: Backward Compatibility & Extension
- **Prefer Extension over Modification:** When adding new features, prefer creating new modules, extensions, or command/handler implementations (`Open/Closed Principle`) rather than modifying complex core logic that risks breaking existing behavior.
- **API Backward Compatibility:** Never remove or rename public API fields without a formal deprecation cycle and versioning strategy (`/api/v1/` -> `/api/v2/`).
- **Database Migrations:** Never generate destructive EF Core migrations (dropping columns/tables without data backup strategies). Always verify zero-downtime compatibility.
