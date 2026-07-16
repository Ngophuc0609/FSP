---
ontology_id: ONT-ARCH-001
category: Architecture Domain Vocabulary
status: Active
version: 1.0.0
owner: Chief Enterprise Architect
last_updated: 2026-07-15
terms:
  - id: TRM-ARCH-001
    term: Domain-Driven Design (DDD)
    definition: "An architectural approach centering software design around core business domain concepts, ubiquitous language, and bounded contexts."
    attributes: [bounded_context, aggregate_root, entity, value_object, domain_event]

  - id: TRM-ARCH-002
    term: Clean Architecture
    definition: "A structural software design pattern that separates application responsibilities into concentric layers with strict inward dependencies."
    attributes: [domain_layer, application_layer, infrastructure_layer, presentation_layer, dependency_inversion]

  - id: TRM-ARCH-003
    term: CQRS (Command Query Responsibility Segregation)
    definition: "An architectural pattern isolating read operations (Queries) from state-mutating write operations (Commands)."
    attributes: [command, command_handler, query, query_handler, read_model, write_model]

  - id: TRM-ARCH-004
    term: Bounded Context
    definition: "An explicit conceptual and physical boundary within which a domain model and ubiquitous language apply consistently."
    attributes: [context_name, domain_models, public_interface, anti_corruption_layer]

  - id: TRM-ARCH-005
    term: Aggregate Root
    definition: "A primary domain entity that acts as the gateway and transactional consistency boundary for a cluster of associated entities and value objects."
    attributes: [entity_id, invariants, child_entities, domain_events]

  - id: TRM-ARCH-006
    term: Anti-Corruption Layer (ACL)
    definition: "An architectural translation layer implemented between different Bounded Contexts or legacy subsystems to prevent domain model pollution."
    attributes: [translator, facade, adapter]

  - id: TRM-ARCH-007
    term: Event Sourcing
    definition: "A state-persistence strategy where changes to an application state are stored as an immutable, chronological sequence of domain events."
    attributes: [event_stream, event_store, projection, snapshot]
---

# Architecture Ontology & Design Principles

## Overview
This file defines the architectural patterns, structural boundaries, and terminology for the FSP repository. AI architecture agents (`backend_architect`, `flutter_architect`, `solution_architect`) must reference this ontology when producing design documents, ADRs, or scaffolding code structures.

## Core Architectural Rules & Layer Definitions

### 1. Clean Architecture Layers (Strict Inward Dependency)
```text
[ Presentation / API / Flutter UI ]
             ↓ (depends on)
     [ Application Layer ]
             ↓ (depends on)
       [ Domain Layer ]
             ↑ (implemented by)
  [ Infrastructure / Persistence ]
```
- **Domain Layer:** Pure business entities, value objects, domain interfaces, and invariants. ZERO external dependencies (no ORM attributes, no HTTP libraries).
- **Application Layer:** Use case orchestration, CQRS Commands/Queries, DTOs, and validation. Depends ONLY on Domain Layer.
- **Infrastructure Layer:** Database access (EF Core/SQL), external service integrations, file system, logging. Implements interfaces defined in the Domain/Application layers.
- **Presentation Layer:** REST API Controllers, Minimal APIs, or mobile UI view models. Orchestrates input to Application Layer.

### 2. CQRS Separation of Concerns
- **Commands:** Mutate state. Must return either `void`, a `Result<T>` wrapper, or the ID of the created entity. Must NEVER execute complex analytical joins or return full view DTOs.
- **Queries:** Read state without side effects. May bypass aggregate invariants and query optimized read models or SQL views directly using high-performance micro-ORMs (e.g., Dapper) or read-only Entity Framework projections.

### 3. FSP Bounded Contexts
FSP is segmented into the following primary Bounded Contexts:
1. **WorkOrderContext:** Managing Work Orders, Tasks, and Inspections.
2. **AssetContext:** Managing equipment registries, maintenance schedules, and telemetry.
3. **DispatchContext:** Managing technician schedules, routing, and real-time location tracking.
4. **IdentityContext:** Managing authentication, RBAC, and organizational multi-tenancy.
