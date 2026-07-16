---
title: Functional Role-Based Access Matrix - Field Service Platform (FSP)
category: business
version: 2.0.0
last_updated: 2026-07-15
---

# FUNCTIONAL ROLE-BASED ACCESS MATRIX (`RBAC`)

## Permission Matrix by User Role

| Domain Entity / Operation | Tenant Administrator (`Admin`) | Service Dispatcher (`Dispatcher`) | Field Technician (`Technician`) | Read-Only Auditor (`Auditor`) |
| :--- | :--- | :--- | :--- | :--- |
| **Create Work Order** | Yes | Yes | No (Only via automated IoT/SLA) | No |
| **Assign / Re-assign Work Order** | Yes | Yes | No | No |
| **Change Status -> In_Progress / Completed**| Yes (Override only) | No | **Yes** (Assigned jobs only) | No |
| **Execute & Sign Inspection Checklist** | No | No | **Yes** (Assigned jobs only) | No |
| **Create / Edit Asset Registry** | Yes | Yes | Read-Only | Read-Only |
| **Manage Tenant Roles & Billing** | **Yes** | No | No | No |
| **View Audit Logs & SLA Performance** | Yes | Yes | No | **Yes** |
