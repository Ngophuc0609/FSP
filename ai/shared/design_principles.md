---
id: design_principles
title: Field Service Platform - Universal Design Principles
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# UNIVERSAL DESIGN PRINCIPLES

All architecture, backend modules, mobile apps, and frontend components inside the Field Service Platform (FSP) must strictly reflect the following core engineering principles:

---

## 1. SOLID Engineering
- **Single Responsibility Principle (SRP):** Every class, handler, or widget must have exactly one reason to change. Separate data validation, persistence, domain calculation, and presentation into distinct classes.
- **Open/Closed Principle (OCP):** Core domain logic and application workflows should be open for extension (via MediatR handlers, strategies, or plugins) but closed for modification.
- **Liskov Substitution Principle (LSP):** Derived classes and implementations must be completely substitutable for their base interfaces without altering correctness.
- **Interface Segregation Principle (ISP):** Prefer small, highly cohesive interfaces (`IWorkOrderRepository`, `IAssetTelemetryReader`) over monolithic interfaces (`IServiceManager`).
- **Dependency Inversion Principle (DIP):** High-level modules must depend on abstractions (Interfaces), never on concrete implementations (such as `SqlConnection` or `Dio`).

---

## 2. Clean Architecture & Layer Boundaries
- **Domain Layer:** Contains zero dependencies. Holds Entities, Value Objects, Domain Events, and Domain Exceptions.
- **Application Layer:** Depends ONLY on Domain. Holds CQRS Commands, Queries, Handlers, DTOs, and Interfaces (`IRepository`, `ICacheService`).
- **Infrastructure Layer:** Depends on Application. Implements interfaces using `EF Core`, `SQL Server`, `Redis`, `Azure Service Bus`.
- **Presentation Layer:** Depends on Application. Holds `ASP.NET Core Controllers`, `Minimal APIs`, or `SignalR Hubs`. Zero database or domain logic allowed.

---

## 3. Offline-First Synchronization Architecture (Mobile)
Field technicians operate in basements, remote construction sites, and rural areas with zero connectivity.
- **Local-First Writes:** Every mobile action (status update, signature capture, checklist item) must be written immediately to local SQLite/Drift database before attempting network sync.
- **Idempotency & Delta Sync:** Sync queues must attach unique `CorrelationId` / `ClientMutationId` to prevent duplicate operations when retried after reconnection.
- **Optimistic UI with Conflict Detection:** UI reflects changes immediately. If server detects concurrent modification, explicit conflict resolution policies (Server-Wins, Client-Wins, or Manual Merge) must be executed cleanly.

---

## 4. Multi-Tenant SaaS Isolation
- **Strict Tenant Partitioning:** Every primary business table (`WorkOrders`, `Assets`, `Technicians`, `Invoices`) MUST contain `TenantId` (`uniqueidentifier` or `bigint`).
- **Automated Query Filtering:** ORM layer (`EF Core Global Query Filters`) MUST automatically inject `WHERE TenantId = @CurrentTenantId` into every read/write query to eliminate cross-tenant data leaks.
- **Tenant Context Injection:** `TenantId` must be resolved from JWT claims at the API gateway/middleware level and passed down immutably via execution context.
