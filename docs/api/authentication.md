---
title: Authentication & Zero-Trust Authorization Specification
category: api
version: 2.0.0
last_updated: 2026-07-15
---

# AUTHENTICATION & ZERO-TRUST AUTHORIZATION

## 1. JWT Bearer Token Architecture
Every HTTP request to `FSP` API endpoints (except `/api/v1/auth/login`) MUST include a valid `Authorization: Bearer <token>` header.

### Mandatory JWT Claims
```json
{
  "sub": "usr_99887766-5544-3322-1100-aabbccddeeff",
  "tid": "tnt_11111111-2222-3333-4444-555555555555",
  "role": "Dispatcher",
  "email": "sarah.dispatcher@enterprise.com",
  "exp": 1784332800,
  "iss": "https://auth.fsp.enterprise.com"
}
```

---

## 2. Multi-Tenant Interception & Middleware
The ASP.NET Core middleware (`TenantResolutionMiddleware`) extracts the `tid` claim from the JWT token and injects it into the scoped `ITenantProvider`.
If a request attempts to supply a `TenantId` in the JSON body that conflicts with the `tid` inside the signed JWT, the API instantly rejects the request with a `403 Forbidden` and logs a security violation audit event.
