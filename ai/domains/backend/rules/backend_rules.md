---
title: Backend Domain Rules (.NET Core 8+ Clean Architecture)
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# BACKEND DOMAIN RULES (`RULE-BACKEND-001` to `005`)

## RULE-BACKEND-001: Pure Domain Layer Invariants (`FSP.Domain`)
1. Entities and Value Objects inside `src/backend/FSP.Domain/` MUST NOT reference `Microsoft.EntityFrameworkCore`, `System.Text.Json`, or any ASP.NET Core framework assembly.
2. All entity constructors must be `private` or `protected`. Creation must happen via static factory methods (`WorkOrder.Create(...)`) that enforce invariants and raise domain events (`IDomainEvent`).

## RULE-BACKEND-002: CQRS MediatR Handlers (`FSP.Application`)
1. Every business use case must be represented by a distinct `IRequest<Result<TResponse>>` command or query inside `FSP.Application/<Module>/Commands/` or `Queries/`.
2. Every MediatR request MUST have a corresponding `AbstractValidator<TRequest>` using `FluentValidation` registered in the dependency injection pipeline.

## RULE-BACKEND-003: Mandatory No-Tracking Queries
All EF Core queries executed inside MediatR `IRequestHandler` query handlers MUST explicitly call `.AsNoTracking()` to prevent memory bloat and change-tracker overhead:
```csharp
var workOrders = await _dbContext.WorkOrders
    .AsNoTracking()
    .Where(w => w.Priority == WorkOrderPriority.Critical)
    .ToListAsync(cancellationToken);
```
