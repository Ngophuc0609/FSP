---
id: review_api
title: Multi-Agent Workflow - API Specification & REST Standard Review
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates API Designer and Code Reviewer to audit endpoint specs against REST standards.
---

# MULTI-AGENT WORKFLOW: API SPECIFICATION REVIEW

This workflow delegates directly to `ai/prompts/design_rest_api.md` and `review_security.md` to ensure all API modifications conform to RESTful guidelines (`ai/standards/rest_standard.md`).

---

## Workflow Verification Points
1. **URI Conventions:** Plural nouns (`/api/v1/work-orders`), kebab-case formatting, and no verb paths (`/getWorkOrder`).
2. **Response Standardization:** Every endpoint must return structured DTOs and handle errors via RFC 7807 `ProblemDetails`.
3. **Idempotency & Auth:** Mutating operations require `X-Idempotency-Key` headers and mandatory JWT authorization tokens.
