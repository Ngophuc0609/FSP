---
id: business_context
title: Field Service Platform - Business Operations Micro-Context
tier: 2_contexts
domain: business
version: 2.0.0
last_updated: 2026-07-15
---

# BUSINESS OPERATIONS MICRO-CONTEXT

## 1. Field Service Operational Lifecycle
The fundamental business value of FSP revolves around executing on-site technical services efficiently:
1. **Service Request Creation:** Customer or IoT alarm triggers a service request (`Break-Fix` or `Preventive Maintenance`).
2. **Work Order Triage & Quotation:** Dispatcher reviews required skills, estimates parts/labor, and issues a quotation if out-of-warranty.
3. **Dispatch & Assignment:** System matches available technician possessing required skills within geographical proximity.
4. **On-Site Execution (Mobile):** Technician checks in via GPS, completes mandatory inspection checklists, consumes spare parts, and captures customer digital signature.
5. **Review & Billing:** Completed work order is verified by dispatch, generating an invoice or updating warranty records.

---

## 2. Key Business Rules & SLAs
- **SLA Breach Thresholds:** High-priority emergency breakdowns (`P1`) must be assigned within 30 minutes and arrived on-site within 2 hours.
- **Technician Skill Enforcement:** A technician CANNOT be assigned to a `Work Order` if their certification for the required `Asset` category is expired or missing.
- **Mandatory Safety Inspection:** For heavy machinery work orders, the mobile app MUST block marking the task as `Completed` until the pre-job safety inspection checklist is 100% checked.
- **Inventory Reservation:** When a work order is assigned, required spare parts in the technician's van stock are marked as `Reserved`. Upon job completion, they transition to `Consumed`.
