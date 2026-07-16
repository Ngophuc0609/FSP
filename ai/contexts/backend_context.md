---
id: backend_context
title: Field Service Platform - Backend Engineering Micro-Context
tier: 2_contexts
domain: backend
version: 2.0.0
last_updated: 2026-07-15
---

# BACKEND ENGINEERING MICRO-CONTEXT (.NET 8)

## 1. Architectural Stack & Structure
The FSP backend is built on **.NET 8 (C# 12+)** adhering strictly to **Clean Architecture** and **CQRS with MediatR**.
The solution structure must follow:
- `src/Domain/`: Zero external dependencies. Contains Entities (`BaseTenantEntity`), Value Objects, Domain Events (`IEvent`), and Exceptions.
- `src/Application/`: Depends ONLY on `Domain`. Contains CQRS Commands (`IRequest<Result<T>>`), Queries, Handlers, FluentValidation rules (`AbstractValidator<T>`), and Interfaces (`IWorkOrderRepository`, `ITenantContext`).
- `src/Infrastructure/`: Depends on `Application`. Implements interfaces using `EF Core 8`, `Microsoft SQL Server`, `Redis`, and `Azure Service Bus`.
- `src/Presentation/`: Depends on `Application`. ASP.NET Core Web API controllers / Minimal APIs.

---

## 2. CQRS & MediatR Implementation Pattern
Every write operation must be represented as an immutable `Command` record. Every read operation must be an immutable `Query` record.

### Command Example Structure
```csharp
public record AssignTechnicianCommand(Guid WorkOrderId, Guid TechnicianId, DateTime ScheduledStart) : IRequest<Result<Guid>>;

public class AssignTechnicianCommandValidator : AbstractValidator<AssignTechnicianCommand>
{
    public AssignTechnicianCommandValidator()
    {
        RuleFor(x => x.WorkOrderId).NotEmpty();
        RuleFor(x => x.TechnicianId).NotEmpty();
        RuleFor(x => x.ScheduledStart).GreaterThan(DateTime.UtcNow);
    }
}
```

### Handler Rules
- Handlers MUST NOT access `HttpContext` directly.
- Handlers MUST NOT write raw SQL queries; use `IRepository<T>` or `IApplicationDbContext`.
- All operations returning errors must return `Result<T>` pattern instead of throwing control-flow exceptions.

---

## 3. Entity Framework Core & Multi-Tenancy Rules
- Every tenant-scoped entity MUST inherit from `BaseTenantEntity` which includes `Guid TenantId`, `DateTime CreatedAtUtc`, `DateTime? UpdatedAtUtc`, `string CreatedBy`.
- `ApplicationDbContext` MUST configure Global Query Filters:
  ```csharp
  builder.Entity<WorkOrder>().HasQueryFilter(e => e.TenantId == _tenantContext.CurrentTenantId);
  ```
- All read-only CQRS queries MUST append `.AsNoTracking()` to prevent unnecessary ORM state tracking overhead.
