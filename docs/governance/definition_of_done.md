---
title: Definition of Done (DoD) - Field Service Platform (FSP)
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# DEFINITION OF DONE (`DoD`)

## Checklist for Every Pull Request / User Story
To be considered **DONE** and eligible for production release, every task must satisfy `100%` of the following criteria:

- [ ] **Clean Architecture Compliance:** Code strictly respects layer boundaries (`Application -> Domain <- Infrastructure`).
- [ ] **Multi-Tenant Security Verified:** All new or modified database entities implement `TenantId` and are covered by EF Core global query filters.
- [ ] **Offline Sync & Ergonomics Verified:** If mobile-facing, feature works offline in `Drift` SQLite and touch targets meet or exceed `48x48px`.
- [ ] **AAA Automated Tests Passed:** Unit, integration, and widget suites pass (`xUnit` / `flutter_test`) with `>= 90%` code coverage.
- [ ] **RFC 7807 Error Handling:** All API endpoints return `ProblemDetails` for validation and domain errors.
- [ ] **Documentation Synced:** Associated ERD (`docs/database/erd.md`), API specs (`docs/api/`), and `ai/knowledge_graph/master_graph.md` have been updated.
- [ ] **Zero Placeholders:** Code contains `0` instances of `TODO`, `FIXME`, or temporary mock strings.
