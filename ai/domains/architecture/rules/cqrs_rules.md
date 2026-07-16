---
rule_id: RULE-ARCH-CQRS-001
title: CQRS Separation of Commands & Queries
severity: HIGH
category: Architecture
domain: architecture
owner: Chief Enterprise Architect
applies_to: [.NET Backend]
required_before: [API Design, Handler Scaffolding]
standard_ref: STD-DDD-001
---

# Command Query Responsibility Segregation (CQRS) Rules

## 1. Description
Enforces the separation of read and write operations to maximize performance, scalability, and security across the FSP backend.

## 2. Rules
*   **Commands (Writes)**:
    *   Must represent an intent to change system state (`CreateWorkOrderCommand`).
    *   Must be validated using `FluentValidation` before execution.
    *   Must return `void`, `Result<T>`, or the ID of the created entity. NEVER return full complex view DTOs.
    *   Must mutate state strictly through Domain Aggregate Roots (`WorkOrder.Assign()`).
*   **Queries (Reads)**:
    *   Must NEVER mutate system state.
    *   Return lightweight Data Transfer Objects (DTOs) specifically tailored to UI screen requirements.
    *   May bypass Domain Layer aggregates and query read-only database views directly using high-performance micro-ORMs (e.g., Dapper) or `EF Core AsNoTracking()`.

## 3. Examples
**Good (Query bypassing Domain for speed)**:
```csharp
public class GetWorkOrderListQueryHandler : IRequestHandler<GetWorkOrderListQuery, List<WorkOrderSummaryDto>> {
    public async Task<List<WorkOrderSummaryDto>> Handle(...) { 
        // Dapper execution reading from optimized SQL view
    }
}
```
