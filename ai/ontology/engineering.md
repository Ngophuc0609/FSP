---
ontology_id: ONT-ENG-001
category: Engineering Domain Vocabulary
status: Active
version: 1.0.0
owner: Principal Software Engineer
last_updated: 2026-07-15
terms:
  - id: TRM-ENG-001
    term: Module
    definition: "A cohesive, self-contained implementation unit encapsulating a specific domain feature with clear public interfaces and internal encapsulation."
    attributes: [module_name, public_contract, internal_services, dependencies]

  - id: TRM-ENG-002
    term: Repository Pattern
    definition: "An abstraction layer over data access infrastructure, presenting data persistence as an in-memory collection of domain entities."
    attributes: [interface_contract, entity_type, query_specifications]

  - id: TRM-ENG-003
    term: Handler
    definition: "An execution class responsible for processing a single specific CQRS Command or Query request (e.g., using MediatR in .NET)."
    attributes: [request_type, response_type, dependencies, validation_behavior]

  - id: TRM-ENG-004
    term: Widget
    definition: "An immutable structural unit of the user interface hierarchy in Flutter applications."
    attributes: [stateless, stateful, build_context, keys, properties]

  - id: TRM-ENG-005
    term: BLoC (Business Logic Component)
    definition: "A state management pattern in Flutter separating presentation views from business logic using reactive streams of Events and States."
    attributes: [events, states, bloc_class, repository_dependencies]

  - id: TRM-ENG-006
    term: Optimistic Mutation
    definition: "A client-side state update technique where the local UI reflects changes immediately before confirming successful server persistence, rolling back on failure."
    attributes: [local_cache, pending_sync_queue, rollback_handler]
---

# Engineering Ontology & Implementation Vocabulary

## Overview
This file establishes precise engineering constructs and terminology for `.NET Core` backend development and `Flutter` mobile development. AI development agents (`backend_dev`, `flutter_dev`) must adhere to these exact definitions when generating class hierarchies and structural modules.

## .NET Backend Implementation Vocabulary

### 1. MediatR Request Handlers
- Every use case in the application layer is represented by a request class implementing `IRequest<TResponse>`.
- Handlers implement `IRequestHandler<TRequest, TResponse>`.
- Handlers must be focused and single-responsibility. Never combine multiple independent operations inside a single handler.

### 2. Result Pattern vs Exceptions
- **Domain Errors & Validation Failures:** MUST be returned using a typed `Result<T>` or `Either<TError, TSuccess>` object. Never throw exceptions for expected flow control or validation errors.
- **Exceptions:** Reserved strictly for unrecoverable technical failures (e.g., `DatabaseConnectionException`, `OutOfMemoryException`).

## Flutter Mobile Implementation Vocabulary

### 1. BLoC Architecture Structure
- **Events:** Noun-verb combinations indicating user actions or system triggers (e.g., `WorkOrderSubmitted`, `AssetQRScanned`).
- **States:** Sealed classes or immutable state instances reflecting UI condition (e.g., `WorkOrderLoading`, `WorkOrderLoaded`, `WorkOrderError`).
- **BLoC Classes:** Receive Events, interact with Repositories, and emit new States. MUST NOT import `dart:ui` or any Flutter widget code.

### 2. Offline-First Synchronization Queue
- Every mobile write operation must first write to a local storage database (SQLite/Isar) and enqueue a `SyncOperationRecord`.
- A background worker synchronizes pending operations with the backend REST API when connectivity is restored.
