---
title: Canonical Project Glossary & Domain Dictionary
category: knowledge
version: 2.0.0
last_updated: 2026-07-15
---

# CANONICAL PROJECT GLOSSARY (`FSP`)

## Core Domain Definitions (Mirrors `ai/ontology/business.md`)

| Canonical Term | Allowed Aliases / Synonyms | Forbidden Terms (`DO NOT USE`) | Exact Definition / Context |
| :--- | :--- | :--- | :--- |
| **`WorkOrder`** | `Job`, `Service Order` | `Ticket`, `Task`, `Order` | The central aggregate root representing a scheduled or emergency field maintenance operation. |
| **`Technician`** | `Field Eng`, `Worker` | `Agent`, `Driver`, `Employee`| A field operations specialist who executes `WorkOrders` on site using the mobile app. |
| **`Assignment`** | `Allocation`, `Dispatch` | `Booking`, `Schedule` | The link record connecting a `Technician` to a specific `WorkOrder` with time and location stamps. |
| **`Inspection`** | `Checklist`, `Safety Audit`| `Form`, `Survey`, `Quiz` | A structured sequence of mandatory validation steps that must be verified on site before job completion. |
| **`Asset`** | `Equipment`, `Machine` | `Device`, `Product`, `Item` | A physical industrial equipment unit (`HVAC`, `Compressor`) installed at a customer site requiring service. |
| **`Tenant`** | `Organization`, `Customer`| `Company`, `Account`, `Group` | An enterprise client organization that owns a distinct, isolated slice of the multi-tenant database. |
