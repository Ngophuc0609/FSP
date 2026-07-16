---
title: Universal Naming Conventions & Code Style Guide
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# UNIVERSAL NAMING CONVENTIONS

## Language & Layer Naming Matrix

| Element / Scope | C# (.NET Core 8+) | Dart (Flutter Mobile) | SQL Database |
| :--- | :--- | :--- | :--- |
| **Classes / Types / Models** | `PascalCase` (`WorkOrder`) | `PascalCase` (`WorkOrder`) | `PascalCase` (`WorkOrders` table) |
| **Methods / Functions** | `PascalCase` (`AssignTechnician`)| `camelCase` (`assignTechnician`)| `PascalCase` (`sp_GetTenantWorkOrders`)|
| **Properties / Columns** | `PascalCase` (`CreatedAtUtc`) | `camelCase` (`createdAtUtc`) | `PascalCase` (`CreatedAtUtc`) |
| **Local Variables / Parameters**| `camelCase` (`tenantId`) | `camelCase` (`tenantId`) | `@camelCase` (`@tenantId`) |
| **Interfaces** | Prefix `I` + `PascalCase` (`IRepository<T>`)| `PascalCase` (`Repository`) | N/A |
| **Files on Disk** | `PascalCase.cs` (`WorkOrder.cs`)| `snake_case.dart` (`work_order.dart`)| `V1__Initial_Schema.sql` |
