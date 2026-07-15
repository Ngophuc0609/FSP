# Command Query Responsibility Segregation (CQRS) Rules

**Identifier**: R-ARCH-CQRS-001
**Category**: Architecture
**Applies To**: Backend (.NET)
**Severity**: High

## 1. Description
Enforces the separation of read and write operations to maximize performance, scalability, and security.

## 2. Rules
*   **Commands (Writes)**:
    *   Must represent an intent to change the system state.
    *   Must be validated before execution.
    *   Should return `void`, a `Task`, or an ID/Status (No complex DTOs).
    *   Must go through the Domain Layer (Aggregates).
*   **Queries (Reads)**:
    *   Must never mutate system state.
    *   Return Data Transfer Objects (DTOs) specifically tailored to the UI requirements.
    *   Are allowed to bypass the Domain Layer and query the database directly (e.g., using Dapper, Raw SQL, or Entity Framework AsNoTracking) for optimal performance.

## 3. Required Before
*   API Design
*   Backend Implementation

## 4. Examples
**Good (Query bypassing Domain)**:
```csharp
public class GetWorkOrderListQueryHandler : IRequestHandler<GetWorkOrderListQuery, List<WorkOrderDto>> {
    // Uses Dapper for fast reads, completely ignoring the Domain Aggregate
    public async Task<List<WorkOrderDto>> Handle(...) { ... }
}
```

## 5. Exceptions
Simple CRUD operations for non-core domains (e.g., settings) may bypass strict CQRS if the overhead outweighs the benefits, subject to Architect approval.
