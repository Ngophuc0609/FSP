---
title: API Versioning Strategy - Field Service Platform (FSP)
category: api
version: 2.0.0
last_updated: 2026-07-15
---

# API VERSIONING STRATEGY

## 1. URI Path Versioning Standard
`FSP` enforces **URI Path Versioning** (`/api/v1/...`, `/api/v2/...`) as the primary mechanism for breaking API changes. Header-based or query-parameter versioning (`?version=1`) is strictly prohibited to ensure transparent CDN caching and clear client routing.

---

## 2. Deprecation & Sunset Lifecycle
When an API endpoint is scheduled for deprecation (`v1` superseded by `v2`):
1. **Sunset Header:** The `v1` endpoint must return HTTP response headers:
   - `Deprecation: true`
   - `Sunset: Sat, 31 Dec 2026 23:59:59 GMT`
2. **Grace Period:** A minimum of `6 months` grace period is required before any deprecated `v1` endpoint is decommissioned from production.
