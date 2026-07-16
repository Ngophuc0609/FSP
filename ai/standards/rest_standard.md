---
standard_id: STD-REST-001
title: REST API Design Standard
version: 1.0.0
owner: API Domain Lead
scope: All HTTP REST API endpoints and OpenAPI/Swagger contracts
rules_referencing: [RULE-API-001, RULE-API-002, RULE-API-003]
---

# REST API Design Standard

## 1. Purpose & Scope
Governs the design of all HTTP API endpoints exposed by FSP backend services.

## 2. URI & Resource Conventions
- **Plural Nouns:** All resource URIs MUST use plural nouns (e.g., `/api/v1/work-orders`, `/api/v1/assets`).
- **Kebab-Case Paths:** URL segments must use lowercase `kebab-case` (`/api/v1/inspection-checklists`).
- **No Verbs in Paths:** Never use verbs in URIs (`/getUsers`, `/createOrder`). Use standard HTTP methods instead (`GET`, `POST`, `PUT`, `DELETE`).

## 3. HTTP Status Codes & Error Responses
- `200 OK`: Successful query retrieval or update with payload.
- `201 Created`: Successful resource creation (MUST return `Location` header).
- `204 No Content`: Successful deletion or command without return payload.
- `400 Bad Request`: Validation failure (MUST return RFC 7807 `ProblemDetails` schema).
- `401 Unauthorized`: Missing or invalid JWT.
- `403 Forbidden`: Authenticated but lacking permission.
- `404 Not Found`: Resource does not exist.
- `409 Conflict`: Business logic or concurrency conflict.

## 4. Pagination & Filtering Standard
All collection `GET` endpoints MUST support offset/limit or cursor pagination:
- Query params: `?page=1&pageSize=20&sortBy=created_at&sortOrder=desc`
