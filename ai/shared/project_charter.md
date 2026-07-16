---
id: project_charter
title: Field Service Platform (FSP) - Project Charter
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# FIELD SERVICE PLATFORM (FSP) - PROJECT CHARTER

## 1. Project Identity
You are working inside a single enterprise project named:
**Field Service Platform (FSP)**

- **This is NOT a demo project.**
- **This is NOT a coding exercise or hobby prototype.**
- **Every response must directly contribute to a production-ready enterprise SaaS system.**

---

## 2. Mission
Build a world-class, enterprise-grade **Field Service Platform** that enables organizations to manage complex, distributed field operations seamlessly. The core capabilities include:

1. **Work Order Management:** Lifecycle tracking from service request, triage, quotation, approval, execution, to billing.
2. **Dynamic Scheduling & Dispatching:** SLA-aware, skill-based, and territorial assignment of technicians to tasks.
3. **Route Optimization:** Real-time and predictive travel time reduction using geolocation and mapping engines.
4. **Asset & Equipment Management:** Deep lifecycle tracking of customer equipment, IoT telemetry, maintenance schedules, and warranty histories.
5. **Technician Mobile Application:** Offline-first, high-performance mobile workspace for field engineers to execute checklists, capture signatures, scan barcodes, and sync data.
6. **Customer Self-Service Portal:** Transparent tracking, appointment booking, approval workflows, and service history access.
7. **Real-time Notifications & Telemetry:** Multi-channel alerts (Push, SMS, Email, SignalR WebSocket) and operational tracking.
8. **Inventory & Spare Parts Management:** Multi-warehouse, van-stock tracking, parts reservation, and consumption logging.
9. **Offline-First Synchronization Engine:** Robust delta-sync, conflict resolution, and background queuing for low-connectivity environments.
10. **Multi-Tenant Enterprise SaaS:** Strict tenant data isolation, RBAC/ABAC granular authorization, and customizable tenant configurations.

---

## 3. Technology Stack

### Backend (.NET Core / Enterprise Cloud)
- **Framework:** `.NET 8` (C# 12+)
- **Architecture Patterns:** Clean Architecture, Domain-Driven Design (DDD), Command Query Responsibility Segregation (CQRS)
- **Core Libraries:** `MediatR` (In-process messaging), `FluentValidation` (Domain & Request validation), `AutoMapper` / `Mapster` (DTO mapping)
- **Database Layer:** `Microsoft SQL Server` (Primary relational store), `Entity Framework Core 8` (ORM with explicit configurations & migrations)
- **Caching & Distributed State:** `Redis` (Distributed caching, rate limiting, and ephemeral token store)
- **Real-Time Communication:** `ASP.NET Core SignalR` (WebSockets for dispatch live tracking and instant notifications)
- **Security & Identity:** `JWT Bearer Authentication`, `OpenID Connect`, `Microsoft Entra ID / Duende IdentityServer` (Multi-tenant federated auth)

### Mobile Application (Field Technician App)
- **Framework:** `Flutter 3.x+` (Dart 3.x with sound null safety)
- **State Management & Dependency Injection:** `Riverpod 2.x` (AsyncNotifier, StateNotifier, ProviderScope)
- **Navigation:** `GoRouter` (Declarative routing, deep linking, and guard middleware)
- **Networking & API:** `Dio` (Interceptors, retry policies, token refresh, and caching)
- **Data Serialization & Models:** `Freezed` + `JsonSerializable` (Immutable domain models and union types)
- **Local Database & Offline Store:** `Drift` (Type-safe SQLite engine) / `Isar` (High-speed NoSQL local storage)
- **Synchronization:** Custom Offline-First Delta Sync Engine with background worker tasks

### Web Frontend (Dispatcher / Admin & Customer Portal)
- **Framework:** `React 18+` / `Next.js App Router` with `TypeScript 5.x`
- **UI Design System:** Modern corporate design system (Tailwind CSS v3/v4 or enterprise component framework)
- **State & Data Fetching:** `TanStack Query (React Query)` for server state, `Zustand` for client UI state

### Infrastructure & DevOps
- **Containerization:** `Docker` multi-stage builds, `Docker Compose` for local orchestration
- **CI/CD Pipelines:** `GitHub Actions` (Automated linting, building, unit testing, integration testing, and Docker registry pushing)
- **Cloud Platform:** `Microsoft Azure` (App Services / AKS, Azure SQL Database, Azure Service Bus, Azure Blob Storage, Azure Application Insights)

---

## 4. Development Philosophy

### ALWAYS:
- **Production-Ready:** Code must handle edge cases, nullability, exceptions, and high concurrency cleanly.
- **Scalable:** Design stateless application layers, horizontal scaling readiness, and efficient database indexing.
- **Secure by Default:** Enforce strict parameter validation, SQL injection prevention (via EF Core parameterization), XSS protection, and explicit authorization checks on every endpoint.
- **Testable:** Decouple dependencies using Interfaces and Dependency Injection. Write unit tests for domain logic and integration tests for API handlers.
- **Maintainable:** Strictly separate concerns across Domain, Application, Infrastructure, and Presentation layers.
- **Reusable:** Build shared design primitives, generic repository patterns, and modular utilities.

### NEVER:
- **No Quick Hacks:** Never bypass architectural layers or write quick/dirty shortcuts just to make a test pass.
- **No Duplicated Code:** Adhere to DRY (Don't Repeat Yourself) while respecting bounded context boundaries.
- **No Business Logic in UI:** Mobile controllers, Flutter widgets, and React components must ONLY handle presentation and state dispatching. ZERO calculation or domain rules in UI.
- **No Hardcoded Values:** Magic numbers, connection strings, API URLs, and configuration keys must reside in environment variables or configuration files.
- **No Violations of Clean Architecture:** Infrastructure layers can depend on Application/Domain, but Domain MUST have zero dependencies on outer layers or external frameworks.

---

## 5. Output Goal
Every generated artifact—whether code, documentation, SQL schema, or test case—**must directly help the FSP repository advance toward a highly reliable, production-grade enterprise SaaS platform**.
