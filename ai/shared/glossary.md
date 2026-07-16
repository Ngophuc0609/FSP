---
id: glossary
title: Field Service Platform - Universal Glossary Index
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# FIELD SERVICE PLATFORM (FSP) - GLOSSARY & ONTOLOGY INDEX

This document serves as the top-tier reference index pointing to the **Canonical Ontology Dictionaries** stored in `ai/ontology/`. All agents must use these terms strictly across all code, database schemas, and API contracts.

---

## 1. Domain Ontology Dictionaries (Detailed Definitions)

For complete semantic definitions, properties, and relationships, refer to:
1. **Business Terms:** [business.md](file:///D:/Workspace/work/FSP/ai/ontology/business.md)
   - Defines: `Work Order`, `Task`, `Assignment`, `Inspection`, `Asset`, `Technician`, `Dispatcher`, `Tenant`, `SLA`, `Quotation`, `Invoice`.
2. **Architecture Concepts:** [architecture.md](file:///D:/Workspace/work/FSP/ai/ontology/architecture.md)
   - Defines: `Clean Architecture`, `DDD`, `Bounded Context`, `Aggregate Root`, `CQRS`, `MediatR`, `Offline-First Sync Engine`.
3. **Engineering & Code Terms:** [engineering.md](file:///D:/Workspace/work/FSP/ai/ontology/engineering.md)
   - Defines: `DTO`, `Command`, `Query`, `Domain Event`, `Riverpod Provider`, `Freezed Model`, `Repository Pattern`.
4. **Testing Concepts:** [testing.md](file:///D:/Workspace/work/FSP/ai/ontology/testing.md)
   - Defines: `Unit Test`, `Integration Test`, `Widget Test`, `Mocking`, `Coverage DoD`.
5. **DevOps & Cloud:** [devops.md](file:///D:/Workspace/work/FSP/ai/ontology/devops.md)
   - Defines: `Containerization`, `CI/CD Pipeline`, `Multi-Tenant Cluster`, `Zero-Downtime Migration`.
6. **Documentation & ADRs:** [documentation.md](file:///D:/Workspace/work/FSP/ai/ontology/documentation.md)
   - Defines: `ADR`, `PRD`, `BRD`, `FSD`, `System Context`.
7. **AI OS Terms:** [ai.md](file:///D:/Workspace/work/FSP/ai/ontology/ai.md)
   - Defines: `Agent Persona`, `Prompt Wrapper`, `Micro-Context`, `Domain-Bounded Basket`, `Impact Traceability`.

---

## 2. Quick Reference Table (Top 10 Core Entities)

| Term | Canonical Definition | Forbidden Synonyms |
| :--- | :--- | :--- |
| **Work Order** | The primary operational transaction item representing field service requests from creation to billing. | `Job`, `Ticket`, `TaskCard`, `Order` |
| **Technician** | Field service engineer or specialist equipped with the mobile app who executes tasks on site. | `Worker`, `Employee`, `Staff`, `Agent` |
| **Dispatcher** | Operations manager responsible for scheduling, assigning, and monitoring technicians via web portal. | `Scheduler`, `Controller`, `Coordinator` |
| **Asset** | Customer equipment, machinery, or IoT device receiving maintenance or inspection. | `Device`, `Machine`, `Product`, `Item` |
| **Assignment** | The temporal allocation linking a `Technician` to a `Work Order` with scheduled start/end times. | `Booking`, `Allocation`, `Schedule` |
| **Tenant** | Enterprise customer organization using our multi-tenant SaaS platform. | `Customer`, `Organization`, `Company` |
| **Inspection** | Structured checklist or diagnostic procedure performed on an `Asset` during a `Work Order`. | `Checklist`, `Audit`, `TestForm` |
| **CQRS Command** | An immutable request object carrying data intended to mutate system state (`IRequest<Result>`). | `Action`, `Mutation`, `UpdateModel` |
| **CQRS Query** | An immutable request object intended to read state without side effects (`IRequest<TResponse>`). | `GetModel`, `FetchRequest` |
| **Riverpod Provider**| Dart/Flutter state container (`AsyncNotifierProvider`) managing async UI state and caching. | `Controller`, `ViewModel`, `Bloc` |
