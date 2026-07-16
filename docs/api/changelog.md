---
title: API Changelog & Release Notes
category: api
version: 2.0.0
last_updated: 2026-07-15
---

# API CHANGELOG & RELEASE NOTES

## [v2.0.0] - 2026-07-15
### Added
- Standardized all endpoints to follow C# Clean Architecture and MediatR CQRS handling.
- Introduced `POST /api/v1/inspections/sync` batch endpoint supporting offline mobile `Drift` delta queue synchronization.
- Enforced global RFC 7807 `ProblemDetails` error response structure across all controllers.

## [v1.0.0] - 2026-01-01 (Legacy Baseline)
### Added
- Initial baseline CRUD endpoints for `WorkOrder` and `Technician` (now superseded by v2.0.0 MediatR pipelines).
