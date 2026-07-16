---
title: Target User Personas - Field Service Platform (FSP)
category: product
version: 2.0.0
last_updated: 2026-07-15
---

# TARGET USER PERSONAS

---

## Persona 1: Marcus - The Field Technician (`Mobile App Primary User`)
- **Role:** HVAC & Industrial Asset Maintenance Technician.
- **Environment:** Basements, rooftops, remote utility substations (frequent offline/dead zones, wearing safety gloves, high glare).
- **Key Responsibilities:**
  - Execute assigned `Work Orders` on site.
  - Perform structured safety and diagnostic `Inspections` (`Checklist`).
  - Capture high-resolution asset photos and customer digital signatures.
- **Pain Points & Frustrations:**
  - Mobile apps that crash or lose inspection checklists when cellular reception drops.
  - Tiny buttons that are impossible to press while wearing heavy work gloves.
  - Slow loading spinners when trying to close out a job.
- **FSP Ergonomic Solution:**
  - Touch-friendly UI with minimum `48x48px` action targets and high contrast ratios.
  - 100% offline-first operations (`Drift` SQLite) with instant local writes and background sync.

---

## Persona 2: Sarah - The Service Dispatcher (`Web Portal Primary User`)
- **Role:** Regional Operations Dispatch Lead.
- **Environment:** Multi-monitor desktop command center, fast-paced, high-stress emergency response.
- **Key Responsibilities:**
  - Triage incoming service requests and emergency breakdowns.
  - Assign jobs (`Assignment`) based on technician certification, location, and SLA priority.
  - Monitor live technician locations and route status.
- **Pain Points & Frustrations:**
  - Double-booking technicians or assigning jobs to technicians lacking specialized asset certifications.
  - Missing SLA breach deadlines due to lack of visual alerts.
- **FSP Solution:**
  - Real-time SLA countdown matrix with color-coded warning indicators (`Critical`, `Warning`, `Safe`).
  - Skill-aware dispatch assignment engine validating technician certifications against asset requirements.

---

## Persona 3: David - The Enterprise Tenant Administrator (`Web Portal Admin`)
- **Role:** Vice President of Field Operations / IT Director.
- **Environment:** Executive office, data reviews, auditing compliance.
- **Key Responsibilities:**
  - Configure multi-tenant billing, organization roles (`RBAC`), and SLA rules.
  - Audit historical job completion records and safety compliance logs.
- **FSP Solution:**
  - Tenant-isolated executive dashboards reporting `FTFR`, `MTTR`, and technician utilization.
