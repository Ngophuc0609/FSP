---
title: Domain-Driven Design (DDD) Specifications - Field Service Platform (FSP)
category: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# DOMAIN-DRIVEN DESIGN (DDD) SPECIFICATIONS

## 1. Ubiquitous Language & Strategic Modeling
Every term used across C# classes, database columns, and Flutter widgets MUST correspond directly to the canonical definitions established in `ai/ontology/business.md`.

---

## 2. Bounded Context Map

```mermaid
graph LR
    subgraph Core [Core Domain: Field Operations]
        WO[Work Order Aggregate]
        AS[Assignment Aggregate]
        IN[Inspection Checklist Aggregate]
    end
    
    subgraph Supporting [Supporting Domain: Asset Registry]
        AT[Asset Aggregate]
    end
    
    subgraph Generic [Generic Domain: Identity & Billing]
        ID[Tenant / User Identity]
        INV[Invoice / Billing]
    end
    
    WO -->|References AssetId| AT
    WO -->|References TenantId| ID
    AS -->|Links Technician & Job| WO
    IN -->|Validates Completion| WO
```

---

## 3. Aggregate Roots & Transaction Boundaries
1. **`WorkOrder` Aggregate Root:** Controls the lifecycle of `WorkOrder`, its status transitions, and associated `Inspection` validation.
2. **`Tenant` Aggregate Root:** Controls organization limits, subscription SLAs, and user memberships.
3. **`Asset` Aggregate Root:** Controls physical equipment history, maintenance intervals, and telemetry logs.

### Transaction Invariant
A single MediatR command handler MUST only mutate **one Aggregate Root per database transaction**. If changing a `WorkOrder` status must trigger billing creation, it MUST be decoupled via a published `WorkOrderCompletedDomainEvent` consumed asynchronously.
