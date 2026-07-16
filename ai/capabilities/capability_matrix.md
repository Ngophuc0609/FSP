---
title: FSP System Capability Matrix - Phase 1 Inventory
category: capability
version: 2.0.0
last_updated: 2026-07-15
---

# SYSTEM CAPABILITY MATRIX (`ai/capabilities/capability_matrix.md`)

## 1. Phase 1 Core Capabilities Matrix
This inventory maps the foundational enterprise capabilities delivered in **Phase 1: Core Domain Entities & Offline Storage**, linking each architectural domain to its governing rules, personas, and target source code location.

| Capability ID | Capability Name | Domain Basket | Assigned Persona | Governing Rules | Target Source Location |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `CAP-CORE-001`| **Multi-Tenant Data Isolation** | `architecture` / `database` | `chief_architect.md` / `db_architect.md` | `RULE-ARCH-001`, `RULE-DB-001` | `src/backend/FSP.Infrastructure/Persistence/` |
| `CAP-CORE-002`| **Work Order Lifecycle & State Machine** | `backend` / `business` | `backend_dev.md` / `business_analyst.md` | `RULE-BACKEND-001`, `RULE-DDD-001` | `src/backend/FSP.Domain/Entities/WorkOrder.cs` |
| `CAP-CORE-003`| **Field Technician Assignment & Dispatch** | `backend` / `api` | `backend_dev.md` / `api_designer.md` | `RULE-API-001`, `RULE-BACKEND-002` | `src/backend/FSP.Application/WorkOrders/Commands/` |
| `CAP-CORE-004`| **Mobile Offline SQLite Storage (`Drift`)**| `flutter` | `flutter_dev.md` | `RULE-FLUTTER-001`, `RULE-FLUTTER-002`| `src/flutter/lib/core/database/` |
| `CAP-CORE-005`| **Offline Sync Queue & Delta Engine** | `flutter` / `backend` | `flutter_dev.md` / `backend_dev.md` | `RULE-FLUTTER-003`, `RULE-API-002` | `src/flutter/lib/features/sync/` & `FSP.Api/Controllers/Sync/` |

---

## 2. Capability Maturity & SLA Targets
- **Zero-Trust Isolation**: 100% of tenant queries are filtered at the EF Core query provider level.
- **Offline Resilience**: Mobile client must operate completely disconnected from Wi-Fi/4G for up to `72 consecutive hours` without data corruption.
- **Sync Convergence**: When reconnected, queued delta transactions must converge with server state in `< 5 seconds` for 500 queued operations.
