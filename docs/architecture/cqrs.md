---
title: Command Query Responsibility Segregation (CQRS) Specifications
category: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# CQRS SPECIFICATIONS & MEDIATR PATTERNS

## 1. CQRS Separation Standard
To prevent read-model performance bottlenecks from degrading transactional write integrity, `FSP` enforces 100% segregation between write mutations (`Commands`) and read queries (`Queries`).

---

## 2. Command Pattern Specification (`Write Stack`)
- **Implements:** `IRequest<Result<TResponse>>` where `Result<T>` encapsulates success/failure without throwing exceptions for control flow.
- **Behavior Pipeline:**
  1. `ValidationBehavior<TRequest, TResponse>`: Executes all registered `FluentValidation` validators.
  2. `LoggingBehavior<TRequest, TResponse>`: Structured log of command execution and execution time.
  3. `TransactionBehavior<TRequest, TResponse>`: Wraps execution inside an EF Core execution strategy transaction.

```csharp
// Example Command Contract
public record CreateWorkOrderCommand(
    Guid TenantId,
    Guid AssetId,
    string Description,
    WorkOrderPriority Priority
) : IRequest<Result<Guid>>;
```

---

## 3. Query Pattern Specification (`Read Stack`)
- **Implements:** `IRequest<Result<TResponse>>` returning read-only DTO projections.
- **Performance Rule:** Query handlers MUST use `DbSet<T>.AsNoTracking()` or raw Dapper SQL queries mapped to flat DTO records. Never return domain entities (`WorkOrder`) from query handlers.
