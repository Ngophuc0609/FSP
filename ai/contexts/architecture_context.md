---
id: architecture_context
title: Field Service Platform - Architecture Overview Micro-Context
tier: 2_contexts
domain: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# ARCHITECTURE OVERVIEW MICRO-CONTEXT (C4 & DDD)

## 1. C4 System Context & Container Overview
The Field Service Platform (FSP) consists of four primary software containers:
1. **FSP Mobile App (Flutter):** Field technician workspace operating offline-first on Android/iOS.
2. **FSP Web Portal (React/TS):** Dispatcher control tower, scheduling Gantt chart, and admin dashboard.
3. **FSP Core API (.NET 8):** Central backend server exposing REST endpoints and SignalR WebSocket hubs.
4. **Data Infrastructure (Cloud):** SQL Server (relational store), Redis (cache/tokens), and Azure Service Bus (event broker).

---

## 2. Bounded Contexts (Tactical DDD)
The system is divided into strict high-cohesion Bounded Contexts:
- **WorkOrder Context:** Manages service requests, task breakdown, status transitions (`Created` -> `Assigned` -> `In-Progress` -> `Completed` -> `Invoiced`), and SLA tracking.
- **Scheduling & Dispatch Context:** Manages technician rosters, shift calendars, skill matching, and route assignments.
- **Asset & Telemetry Context:** Manages customer equipment inventory, serial numbers, maintenance schedules, and IoT alarms.
- **Inventory & Parts Context:** Manages spare parts warehouses, van stock, reservations, and consumption during work orders.
- **Identity & Tenant Context:** Manages SaaS organizations, user accounts, and RBAC/ABAC role definitions.

---

## 3. Cross-Context Communication (Domain Events)
Bounded contexts must NEVER directly query or mutate another context's internal database tables.
- **In-Process Integration:** Use MediatR `IDomainEventNotification` published when an aggregate changes state (e.g., `WorkOrderCompletedEvent` triggers `InventoryConsumptionHandler`).
- **Out-of-Process Integration:** Publish integration events (`WorkOrderCompletedIntegrationEvent`) over Azure Service Bus for external accounting or ERP integrations.
