# Domain-Driven Design (DDD) Rules

**Identifier**: R-ARCH-DDD-001
**Category**: Architecture
**Applies To**: Backend (.NET)
**Severity**: High

## 1. Description
Enforces tactical Domain-Driven Design patterns to ensure robust modeling of complex business logic in the Field Service Platform.

## 2. Rules
*   **Aggregates & Invariants**: An Aggregate is a transaction boundary. All state changes within an Aggregate must protect its business invariants. 
*   **One Aggregate Per Transaction**: A database transaction must only modify a single Aggregate. If multiple Aggregates need to be updated, use **Domain Events** for eventual consistency.
*   **Value Objects**: Concepts without a conceptual identity (e.g., Address, Money, Coordinates) must be modeled as immutable Value Objects.
*   **Domain Events**: Use domain events to explicitly model side effects that occur within the domain.

## 3. Required Before
*   Database Schema Design
*   Backend Module Implementation

## 4. Examples
**Good (Protecting Invariants)**:
```csharp
public class WorkOrder : AggregateRoot {
    public WorkOrderStatus Status { get; private set; }
    
    public void Complete(DateTime completionTime) {
        if (Status != WorkOrderStatus.InProgress) throw new DomainException("...");
        Status = WorkOrderStatus.Completed;
        AddDomainEvent(new WorkOrderCompletedEvent(this.Id, completionTime));
    }
}
```

**Anti-pattern**:
Public setters on Domain Entities (`public WorkOrderStatus Status { get; set; }`).

## 5. References
*   [Domain-Driven Design by Eric Evans]
*   [Microsoft Microservices Architecture (eShopOnContainers)](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/)
