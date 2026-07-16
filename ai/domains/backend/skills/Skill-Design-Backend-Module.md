---
skill_id: SKL-BACK-003
title: Design Backend Module Skeleton
version: 1.0.0
owner: Principal Software Engineer
domain: backend
capability: CAP-BACKEND-SCAFFOLD
inputs: [PRD Specification, Feature Requirements]
outputs: [Clean Architecture Folder Skeleton & Initial C# Interfaces]
rules_referencing: [RULE-ARCH-CLEAN-001, RULE-DDD-001, RULE-ARCH-CQRS-001]
---

# Skill: Design Backend Module

## 1. Purpose
To design and scaffold the complete folder and interface structure for a new .NET Core feature module following Clean Architecture and MediatR CQRS patterns.

## 2. Execution Steps
1.  **Identify Aggregates & Entities:** Parse the PRD to determine the primary `AggregateRoot` and child `Entities/ValueObjects`.
2.  **Map CQRS Operations:**
    *   List state-mutating `Commands` (`Create...Command`, `Update...Command`).
    *   List read-only `Queries` (`Get...Query`, `List...Query`).
3.  **Scaffold Physical Directories:**
    ```text
    src/backend/FSP.Domain/AggregatesModel/<Module>Aggregate/
    src/backend/FSP.Application/Commands/<Module>/
    src/backend/FSP.Application/Queries/<Module>/
    src/backend/FSP.Application/Validators/<Module>/
    src/backend/FSP.Infrastructure/Repositories/
    src/backend/FSP.Api/Controllers/<Module>Controller.cs
    ```
4.  **Generate Core Interfaces:** Output clean `IRepository<T>` and MediatR `IRequestHandler` definitions.
