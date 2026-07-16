---
title: RESTful API Development Guidelines - Field Service Platform (FSP)
category: api
version: 2.0.0
last_updated: 2026-07-15
---

# RESTFUL API DEVELOPMENT GUIDELINES

## 1. URL Path & Naming Conventions
- Always use plural nouns for resource collections (`/api/v1/work-orders`, `/api/v1/assets`).
- Always use `kebab-case` for multi-word segments (`/work-order-types`).
- Never use verbs in paths (`/createWorkOrder` is STRICTLY FORBIDDEN). HTTP methods (`POST`, `PUT`, `DELETE`) define the action.

---

## 2. Standard HTTP Status Codes
- `200 OK`: Successful read query or update operation returning data.
- `201 Created`: Successful creation of a new resource (MUST include `Location` header pointing to the URI of the created resource).
- `204 No Content`: Successful deletion (`DELETE`) where no payload is returned.
- `400 Bad Request`: Payload structure or business rule validation failure (`FluentValidation`).
- `401 Unauthorized`: Missing, expired, or invalid JWT Bearer token.
- `403 Forbidden`: Authenticated user lacks `RBAC` permissions for this resource or belongs to a different `TenantId`.
- `404 Not Found`: Resource ID does not exist within the current tenant's boundary.
- `409 Conflict`: Concurrency conflict or duplicate resource invariant violation.

---

## 3. RFC 7807 ProblemDetails Standard
All error responses MUST conform to RFC 7807 `ProblemDetails` JSON schema:
```json
{
  "type": "https://errors.fsp.com/validation-error",
  "title": "One or more validation errors occurred.",
  "status": 400,
  "detail": "The Priority field is required when creating a Critical Work Order.",
  "instance": "/api/v1/work-orders",
  "errors": {
    "Priority": ["The Priority field is required."],
    "AssetId": ["The specified Asset does not exist."]
  }
}
```
