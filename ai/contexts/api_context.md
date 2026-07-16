---
id: api_context
title: Field Service Platform - REST API & Gateway Micro-Context
tier: 2_contexts
domain: api
version: 2.0.0
last_updated: 2026-07-15
---

# REST API & GATEWAY MICRO-CONTEXT

## 1. RESTful Design & URL Naming Conventions
- **URL Path Standards:** Use plural nouns and `kebab-case` (`/api/v1/work-orders`, `/api/v1/assets/{assetId}/telemetry`).
- **HTTP Methods:**
  - `GET`: Retrieve resource(s) (Idempotent, Safe).
  - `POST`: Create new resource or trigger complex business commands (`/api/v1/work-orders/{id}/assign`).
  - `PUT`: Full update of a resource (Idempotent).
  - `PATCH`: Partial update of specific fields.
  - `DELETE`: Soft delete resource (`IsDeleted = true`).

---

## 2. Error Handling & RFC 7807 ProblemDetails
Never return raw text or stack traces to clients. All API responses reporting errors (4xx, 5xx) must return RFC 7807 `ProblemDetails` JSON format:
```json
{
  "type": "https://errors.fsp.enterprise/validation-failed",
  "title": "Domain Validation Error",
  "status": 400,
  "detail": "One or more validation errors occurred while assigning the technician.",
  "instance": "/api/v1/work-orders/8f9d0c2e/assign",
  "extensions": {
    "errorCode": "FSP-WO-1004",
    "errors": {
      "ScheduledStart": ["Scheduled start time cannot be in the past."]
    }
  }
}
```

---

## 3. Authentication, Authorization & Security Headers
- Every request to protected endpoints must carry a `Authorization: Bearer <jwt_token>` header.
- Middleware extracts claims: `sub` (UserId), `tenant_id` (TenantId), and `roles` (`Dispatcher`, `Technician`, `Admin`).
- Controllers or API endpoints must explicitly declare authorization requirements:
  ```csharp
  [Authorize(Policy = "RequireDispatcherRole")]
  [HttpPost("{id}/assign")]
  public async Task<IActionResult> AssignTechnician(Guid id, [FromBody] AssignTechnicianDto dto)
  ```
- **Idempotency Header:** For critical state mutating POST requests from mobile devices, check `X-Idempotency-Key` header to prevent duplicate executions during network retries.
