---
title: Business Rules & Domain Invariants - Field Service Platform (FSP)
category: business
version: 2.0.0
last_updated: 2026-07-15
---

# BUSINESS RULES & DOMAIN INVARIANTS

## Domain Rule Catalog

### `BR-TENANT-001` - Mandatory Tenant Ownership
Every primary aggregate (`WorkOrder`, `Asset`, `Technician`, `Inspection`) MUST contain a non-nullable `TenantId` property. No domain entity may exist outside the boundary of an enterprise `Tenant`.

### `BR-ASSIGN-001` - Single Active Technician Assignment
A `WorkOrder` in `Assigned` or `In_Progress` status MUST have exactly one active `Assignment`. If a job requires multiple technicians, parent/child `WorkOrder` split tasks must be created.

### `BR-SLA-001` - Critical Priority SLA Threshold
Any `WorkOrder` generated with `Priority = Critical` automatically assigns an SLA target completion window (`DueAtUtc`) of exactly `4 hours` from `CreatedAtUtc`. If not `Assigned` within `30 minutes`, an automated escalation domain event (`SlaBreachWarningEvent`) is triggered.

### `BR-AUDIT-001` - Immutable Proof of Service
Once an `Inspection` checklist and digital signature are captured on site by a technician and synced to the central database, the inspection results are permanently frozen (`IsReadOnly = true`). Neither dispatchers nor administrators may modify completed checkmarks or signatures.
