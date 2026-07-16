---
rule_id: RULE-DDD-001
title: Domain-Driven Design & Aggregate Invariants Rule
severity: HIGH
category: Architecture
domain: architecture
owner: Chief Enterprise Architect
applies_to: [.NET Backend]
required_before: [Database Schema Design, Domain Modeling]
standard_ref: STD-DDD-001
---

# Domain-Driven Design (DDD) Rules

## 1. Description
Enforces tactical Domain-Driven Design patterns to ensure robust modeling of complex field service business logic.

## 2. Rules
*   **Aggregates & Invariants**: An Aggregate is a transactional consistency boundary. All state mutations within an Aggregate must protect its business invariants.
*   **One Aggregate Per Transaction**: A database transaction must only modify a single Aggregate instance. If multiple Aggregates must change concurrently, emit **Domain Events** (`WorkOrderCompletedEvent`) for eventual consistency.
*   **Value Objects**: Concepts without conceptual identity (`Coordinates`, `Money`, `Address`) must be modeled as immutable `Value Objects`.
*   **No Public Setters**: Domain entities MUST NEVER expose public setters on properties (`public WorkOrderStatus Status { get; set; }` is strictly forbidden).

## 3. Examples
**Good (Protecting Invariants)**:
```csharp
public class WorkOrder : AggregateRoot {
    public WorkOrderStatus Status { get; private set; }
    
    public void Complete(DateTime completionTime) {
        if (Status != WorkOrderStatus.InProgress) throw new DomainException("Cannot complete work order unless in progress.");
        Status = WorkOrderStatus.Completed;
        AddDomainEvent(new WorkOrderCompletedEvent(this.Id, completionTime));
    }
}
```
