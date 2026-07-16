---
title: Enterprise Architecture Overview - Field Service Platform (FSP)
category: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# ENTERPRISE ARCHITECTURE OVERVIEW

## 1. C4 System Context Diagram (Level 1)

```mermaid
C4Context
    title C4 System Context Diagram - Field Service Platform (FSP)
    
    Person(tech, "Field Technician", "Executes work orders offline/online via Flutter mobile device.")
    Person(disp, "Service Dispatcher", "Routes jobs and monitors live SLAs via Web Portal.")
    Person(admin, "Tenant Admin", "Configures organization roles, billing, and audit reports.")
    
    System(fsp, "Field Service Platform (FSP)", "Enterprise multi-tenant SaaS for managing field operations, offline syncing, and asset histories.")
    
    System_Ext(iot, "IoT Telemetry Platform", "External sensor network transmitting asset vibration/temperature alerts.")
    System_Ext(smtp, "SendGrid / SMTP", "Email notification gateway for SLA breach alerts.")
    
    Rel(tech, fsp, "Executes jobs & syncs SQLite delta queues", "HTTPS / REST / JSON")
    Rel(disp, fsp, "Monitors live dispatch & SLA matrix", "HTTPS / REST / WebSockets")
    Rel(admin, fsp, "Manages tenant configurations", "HTTPS / REST")
    Rel(iot, fsp, "Pushes anomaly webhooks", "HTTPS / Webhook")
    Rel(fsp, smtp, "Dispatches email alerts", "SMTP / API")
```

---

## 2. Multi-Tenant Enterprise Isolation Strategy
FSP uses a **Pool Tenant Strategy (Shared Database, Shared Schema, TenantId Partitioning)** to achieve high scalability and cost efficiency while enforcing rigorous data security:
- Every table includes `TenantId` (`uniqueidentifier`, indexed).
- EF Core `ApplicationDbContext` automatically intercepts every LINQ query and injects `WHERE TenantId = @tenantId`.
- JWT Bearer tokens contain a mandatory `tid` claim validated on every API request.
