---
ontology_id: ONT-BUS-001
category: Business Domain Vocabulary
status: Active
version: 1.0.0
owner: Business Analysis Domain Lead
last_updated: 2026-07-15
terms:
  - id: TRM-BUS-001
    term: Work Order
    definition: "A formal operational directive assigned to field technicians to perform maintenance, inspection, or repair tasks on specific physical or digital assets."
    attributes: [id, status, priority, title, description, scheduled_start, scheduled_end, actual_start, actual_end, asset_id, assigned_technician_id, customer_id]
    relations:
      has_many: [Task, Inspection, Assignment, WorkOrderComment, SparePartUsage]
      belongs_to: [Asset, Customer, ServiceContract]
      assigned_to: [Technician]

  - id: TRM-BUS-002
    term: Task
    definition: "An atomic, measurable unit of work within a Work Order that must be completed by a technician."
    attributes: [id, work_order_id, sequence_order, title, instructions, status, is_mandatory, completed_at]
    relations:
      belongs_to: [WorkOrder]
      has_one: [InspectionChecklist]

  - id: TRM-BUS-003
    term: Assignment
    definition: "The scheduling and dispatch record linking a Work Order or Task to a qualified Field Technician within a specific time slot."
    attributes: [id, work_order_id, technician_id, status, assigned_by, assigned_at, dispatch_method]
    relations:
      belongs_to: [WorkOrder, Technician]

  - id: TRM-BUS-004
    term: Inspection
    definition: "A structured evaluation process conducted on an Asset using a predefined checklist to verify compliance, safety, or operational health."
    attributes: [id, work_order_id, asset_id, checklist_template_id, status, score, passed, conducted_at]
    relations:
      belongs_to: [WorkOrder, Asset, ChecklistTemplate]
      has_many: [InspectionItemResult]

  - id: TRM-BUS-005
    term: Asset
    definition: "A physical equipment, machinery, device, or property owned by a customer that requires periodic maintenance, monitoring, or servicing."
    attributes: [id, serial_number, name, model, manufacturer, status, location_coordinates, install_date, warranty_expiry]
    relations:
      belongs_to: [Customer, AssetCategory]
      has_many: [WorkOrder, Inspection, AssetHistory]

  - id: TRM-BUS-006
    term: Technician
    definition: "A field service professional equipped with mobile tools who executes scheduled Work Orders and Inspections on-site."
    attributes: [id, user_id, employee_code, skills, certifications, current_status, current_location]
    relations:
      has_many: [Assignment, WorkOrder]

  - id: TRM-BUS-007
    term: Service Contract
    definition: "A legally binding agreement between FSP and a Customer specifying Service Level Agreements (SLAs), coverage terms, and preventive maintenance cadences."
    attributes: [id, customer_id, contract_number, start_date, end_date, sla_type, status]
    relations:
      belongs_to: [Customer]
      has_many: [WorkOrder, Asset]

  - id: TRM-BUS-008
    term: SLA Policy
    definition: "A set of rules defining the target response and resolution times for a Work Order based on business hours and holiday calendars."
    attributes: [id, name, target_response_minutes, target_resolution_minutes, calendar_id]
    relations:
      has_many: [WorkOrder]

  - id: TRM-BUS-009
    term: SLA Tracker
    definition: "A monitoring record attached to a Work Order that tracks the accumulated working minutes and next SLA checkpoint, factoring in pauses and business hours."
    attributes: [status, accumulated_working_minutes, next_checkpoint_utc, warning_notified_utc, breach_notified_utc]
    relations:
      belongs_to: [WorkOrder]
---

# Business Ontology & Domain Vocabulary

## Overview
This file defines the canonical business vocabulary for the Field Service Platform (FSP). Any AI agent (`business_analyst`, `api_designer`, `backend_dev`, `flutter_dev`) or human engineer must strictly adopt these exact terms, attribute structures, and relationships when designing databases, APIs, or UI screens.

## Domain Core Concepts

### 1. The Work Order Lifecycle
A `Work Order` progresses through precise operational states:
- **Draft:** Newly created, incomplete details.
- **PendingDispatch:** Ready to be assigned to a technician.
- **Assigned:** Dispatched and acknowledged by a `Technician`.
- **EnRoute:** Technician is traveling to the `Asset` location.
- **InProgress:** Work/Tasks are actively being performed on-site.
- **OnHold:** Paused due to missing parts or customer delays.
- **Completed:** All mandatory `Tasks` and `Inspections` finished and signed off.
- **Cancelled:** Terminated prior to completion.

### 2. Task & Inspection Differentiation
- A **Task** represents an operational step (e.g., "Replace air filter").
- An **Inspection** represents an evaluation against criteria (e.g., "Check oil pressure level > 50 PSI").
- Never conflate a `Task` with an `Inspection` in database entities or API endpoints.

### 3. Offline Sync & Field Constraints
Because `Technicians` operate in remote field locations with poor network connectivity, all mobile domain entities related to `Work Order`, `Task`, `Inspection`, and `Asset` MUST support offline persistence and optimistic synchronization when connectivity is restored.
