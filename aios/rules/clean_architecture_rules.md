# Clean Architecture Rules

**Identifier**: R-ARCH-CLEAN-001
**Category**: Architecture
**Applies To**: Backend (.NET), Flutter
**Severity**: Critical (Blocker)

## 1. Description
Enforces the principles of Clean Architecture as defined by Robert C. Martin (Uncle Bob). The primary goal is the separation of concerns and ensuring that business logic is independent of frameworks, UI, databases, and external agencies.

## 2. Dependency Rule
*   Source code dependencies must **only point inward**, toward higher-level policies (Domain).
*   Nothing in an inner circle can know anything at all about something in an outer circle.
*   **Domain Layer**: Must have zero external dependencies (no Entity Framework, no HTTP clients).
*   **Application Layer**: Orchestrates use cases. Depends only on the Domain Layer.
*   **Infrastructure Layer**: Implements persistence, external APIs, etc. Depends on Application Layer interfaces.
*   **Presentation Layer**: Web API or UI. Depends on Application Layer.

## 3. Required Before
*   Module Initialization
*   Pull Request Review

## 4. Examples
**Good**:
```csharp
// Application Layer interface
public interface IOrderRepository {
    Task<Order> GetByIdAsync(Guid id);
}

// Infrastructure Layer implementation
public class SqlOrderRepository : IOrderRepository { ... }
```

**Anti-pattern**:
```csharp
// Domain Layer depending on Infrastructure/DB (VIOLATION)
using Microsoft.EntityFrameworkCore;
public class Order { ... }
```

## 5. References
*   [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
