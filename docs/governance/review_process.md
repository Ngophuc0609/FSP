---
title: Code Review Process & Automated Quality Gates
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# CODE REVIEW PROCESS & AUTOMATED QUALITY GATES

## 1. Mandatory PR Review Protocol
Every Pull Request must undergo a 2-stage verification before merging into `main` or `develop`:
1. **Automated AI Review Gate (`review_security.md` + `review_performance.md`):** Automatically scans for SQL injection, missing `TenantId` global query filters, un-parameterized logs, and N+1 query loops.
2. **Human Peer Code Review:** At least one domain CODEOWNER (`@chief-backend-lead` or `@flutter-mobile-lead`) must approve the structural design.

---

## 2. Hard Rejection Criteria (`Zero-Tolerance`)
A Pull Request will be rejected instantly without human review if:
- It introduces a direct reference from `FSP.Domain` to `Microsoft.EntityFrameworkCore`.
- It executes a MediatR query handler without `.AsNoTracking()`.
- It decreases unit/integration test code coverage below `90%`.
- It leaves any `TODO` or `FIXME` comments without an active Jira/Linear ticket ID.
