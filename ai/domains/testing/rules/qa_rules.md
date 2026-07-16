---
title: Quality Assurance & Testing Rules (AAA & Testcontainers)
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# TESTING & QA RULES (`RULE-QA-001` to `004`)

## RULE-QA-001: Mandatory AAA Test Method Structure
Every test method (`xUnit` or `flutter_test`) MUST clearly separate `// Arrange`, `// Act`, and `// Assert` sections.

## RULE-QA-002: Testcontainers for Database Integration Tests
EF Core in-memory database (`UseInMemoryDatabase`) is forbidden for integration tests because it ignores raw SQL and query filters. All integration tests inside `tests/FSP.IntegrationTests/` MUST use `Testcontainers.MsSql` to run tests against ephemeral Docker SQL Server instances.

## RULE-QA-003: Zero-Regression Coverage Boundary
Pull requests must maintain minimum code coverage:
- `FSP.Domain` & `FSP.Application`: `>= 90%` coverage.
- `src/flutter/lib/`: `>= 80%` coverage.
