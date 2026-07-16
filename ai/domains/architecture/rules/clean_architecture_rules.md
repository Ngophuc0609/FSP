---
rule_id: RULE-ARCH-CLEAN-001
title: Clean Architecture Dependency Rule
severity: CRITICAL
category: Architecture
domain: architecture
owner: Chief Enterprise Architect
applies_to: [.NET Backend, Flutter Mobile]
required_before: [Module Scaffolding, Pull Request Review]
standard_ref: STD-DDD-001
---

# Clean Architecture Dependency Rule

## 1. Description
Enforces the principles of Clean Architecture as defined by Robert C. Martin (Uncle Bob). The primary goal is the separation of concerns and ensuring that business logic is independent of frameworks, UI, databases, and external agencies.

## 2. Dependency Rule
*   Source code dependencies must **only point inward**, toward higher-level policies (Domain).
*   Nothing in an inner circle can know anything at all about something in an outer circle.
*   **Domain Layer**: Must have zero external dependencies (no Entity Framework, no HTTP clients, no ORM attributes).
*   **Application Layer**: Orchestrates use cases via MediatR. Depends only on the Domain Layer.
*   **Infrastructure Layer**: Implements persistence, external APIs, logging, etc. Depends on Application Layer interfaces.
*   **Presentation Layer**: Web API Controllers or Minimal APIs. Depends on Application Layer.

## 3. Machine-Readable Violation Condition
```yaml
violation_trigger:
  layer: Domain
  forbidden_imports:
    - Microsoft.EntityFrameworkCore
    - ASP.NET
    - System.Net.Http
    - System.Data.SqlClient
```

## 4. Examples
**Good (`FSP.Application`)**:
```csharp
public interface IWorkOrderRepository {
    Task<WorkOrder> GetByIdAsync(Guid id);
}
```

**Anti-pattern (`FSP.Domain`)**:
```csharp
using Microsoft.EntityFrameworkCore; // VIOLATION: Domain cannot depend on EF Core
public class WorkOrder { ... }
```
