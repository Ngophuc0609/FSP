---
standard_id: STD-NAME-001
title: Code & Artifact Naming Standard
version: 1.0.0
owner: Principal Software Engineer
scope: All code symbols, database objects, and AI artifacts across FSP
rules_referencing: [RULE-NAME-001, RULE-NAME-002]
---

# Code & Artifact Naming Standard

## 1. Code Symbol Naming
- **C# / .NET Backend:**
  - Classes, Interfaces, Methods, Properties: `PascalCase` (`WorkOrderService`, `IWorkOrderRepository`, `GetByIdAsync`).
  - Private fields: `_camelCaseWithUnderscore` (`_workOrderRepository`).
  - Local variables & parameters: `camelCase` (`workOrderId`).
- **Dart / Flutter Mobile:**
  - Classes & Enums: `PascalCase` (`WorkOrderScreen`, `InspectionStatus`).
  - Variables, Methods, Parameters: `camelCase` (`fetchWorkOrders()`).
  - File names: `snake_case` (`work_order_screen.dart`, `work_order_bloc.dart`).

## 2. Database Naming
- Tables: Plural `snake_case` (`work_orders`, `inspection_checklists`).
- Columns: Singular `snake_case` (`work_order_id`, `created_at`).
- Foreign Keys: `fk_<table_name>_<referenced_table>_<column>` (`fk_tasks_work_orders_work_order_id`).
