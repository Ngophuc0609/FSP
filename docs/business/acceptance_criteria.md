---
title: Acceptance Criteria & Verification Matrix - Field Service Platform (FSP)
category: business
version: 2.0.0
last_updated: 2026-07-15
---

# ACCEPTANCE CRITERIA & VERIFICATION MATRIX

## 1. Work Order Creation & Assignment (`AC-WO-001`)
- **Given** an authenticated `Dispatcher` viewing the web dashboard,
- **When** they submit a new `WorkOrder` payload with valid `TenantId`, `AssetId`, and `Priority`,
- **Then** the system must persist the record with status `Draft` within `< 200ms`,
- **And** emit a `WorkOrderCreatedDomainEvent` to notify downstream MediatR handlers.

---

## 2. Mobile Offline Checklist Completion (`AC-MOB-001`)
- **Given** a `Technician` operating the Flutter mobile app in Airplane Mode (zero network),
- **When** they check off all mandatory items on an `Inspection` checklist and sign the screen,
- **Then** the data must be persisted to the local `Drift` SQLite database instantly (`< 50ms`),
- **And** a new payload entry must be inserted into the local `SyncQueueTable` marked as `Pending`.

---

## 3. Background Sync & Conflict Resolution (`AC-SYNC-001`)
- **Given** a mobile device transitioning from offline (Airplane Mode) to online (4G/Wi-Fi),
- **When** the `ConnectivityMonitor` detects stable connection,
- **Then** the background worker must transmit all `Pending` items in `SyncQueueTable` sequentially,
- **And** upon HTTP `200 OK` / `201 Created` confirmation from the API, mark local sync queue items as `Synced`.

---

## 4. Multi-Tenant Zero-Trust Isolation (`AC-SEC-001`)
- **Given** an authenticated user belonging to `Tenant A` (`TenantId = '11111111-1111-1111-1111-111111111111'`),
- **When** they execute any MediatR query or API GET request (`/api/v1/work-orders`),
- **Then** the EF Core database engine must only return records where `TenantId == '11111111-1111-1111-1111-111111111111'`,
- **And** return `0 records` (never a `500 error`) if attempting to query `Tenant B` asset IDs directly.
