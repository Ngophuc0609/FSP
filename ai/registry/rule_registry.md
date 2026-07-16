---
registry_id: REG-RUL-001
title: Master Rule Registry
version: 2.0.0
owner: Chief Enterprise Architect
last_updated: 2026-07-15
token_estimate: ~450 tokens
---

# Master Rule Registry

This index lists all machine-readable constraints across FSP. Automated linters (`ai_reviewer`) and developers must verify compliance with these rules before submitting pull requests.

| Rule ID | Severity | Domain Basket | Target File Path | Violation Description |
| :--- | :--- | :--- | :--- | :--- |
| `RULE-DDD-001` | **BLOCKING** | `architecture` | `ai/domains/architecture/rules/clean_architecture_rules.md` | Domain layer importing EF Core, ASP.NET, or external infrastructure packages |
| `RULE-DDD-002` | **BLOCKING** | `architecture` | `ai/domains/architecture/rules/ddd_rules.md` | Modifying child entities directly outside of an Aggregate Root boundary |
| `RULE-API-001` | **CRITICAL** | `api` | `ai/domains/api/rules/rest_api_rules.md` | Using verbs inside REST URI paths (`/getUsers`) or non-kebab-case URLs |
| `RULE-BACKEND-001` | **BLOCKING** | `backend` | `ai/domains/backend/rules/backend_rules.md` | Domain entities referencing external infrastructure packages or lacking static factories |
| `RULE-BACKEND-003` | **CRITICAL** | `backend` | `ai/domains/backend/rules/backend_rules.md` | MediatR query handlers executing without `.AsNoTracking()` |
| `RULE-FLUTTER-001` | **CRITICAL** | `flutter` | `ai/domains/flutter/rules/flutter_rules.md` | Flutter features violating Feature-First structure (`lib/features/<name>/`) |
| `RULE-FLUTTER-002` | **BLOCKING** | `flutter` | `ai/domains/flutter/rules/flutter_rules.md` | Fetching API payloads directly to UI without storing in local `Drift` SQLite first |
| `RULE-DB-001` | **BLOCKING** | `database` | `ai/domains/database/rules/database_rules.md` | Tables lacking `TenantId` or EF Core queries lacking global query filters |
| `RULE-QA-001` | **CRITICAL** | `testing` | `ai/domains/testing/rules/qa_rules.md` | Unit/Widget tests not using explicit `// Arrange`, `// Act`, `// Assert` sections |
| `RULE-QA-002` | **BLOCKING** | `testing` | `ai/domains/testing/rules/qa_rules.md` | Using `UseInMemoryDatabase()` instead of `Testcontainers.MsSql` for integration tests |
| `RULE-DEVOPS-001`| **CRITICAL** | `devops` | `ai/domains/devops/rules/devops_rules.md` | Dockerfiles running as root user instead of `appuser` (UID 5678) |
| `RULE-BA-001` | **MAJOR** | `business` | `ai/domains/business/rules/ba_rules.md` | Using non-canonical synonyms (`Ticket`, `Job`) in requirements documents |
| `RULE-UI-001` | **MAJOR** | `design` | `ai/domains/design/rules/ui_rules.md` | Touch target boxes smaller than `48x48px` or contrast ratios below `WCAG 2.1 AA` |
