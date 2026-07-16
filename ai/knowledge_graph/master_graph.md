---
graph_id: KGRAPH-MASTER-001
title: FSP Master Knowledge Graph & Relational Matrix
version: 1.0.0
owner: Chief Enterprise Architect
last_updated: 2026-07-15
---

# FSP Master Knowledge Graph & Impact Traceability Matrix

## 1. Overview
This file serves as the centralized relational map connecting high-level business features down to low-level database tables, UI screens, security permissions, offline sync queues, and automated test cases.

When any layer of the application changes, AI agents and engineers MUST consult this graph to execute a full **Impact Analysis** and ensure zero regressions across downstream components.

---

## 2. Full Relational Chain Diagram (Mermaid)

```mermaid
graph TD
    %% Layer Definitions
    subgraph L1 [1. Business & Feature Layer]
        F_WorkOrder["Feature: Work Order Execution"]
        F_Inspection["Feature: Asset Inspection"]
    end

    subgraph L2 [2. Domain & Business Rules]
        BR_WO_01["Rule: Work Order cannot complete without mandatory tasks"]
        BR_INS_01["Rule: Inspection score < 70 triggers maintenance alert"]
    end

    subgraph L3 [3. API & Application Layer]
        API_WO_Complete["POST /api/v1/work-orders/{id}/complete"]
        API_INS_Submit["POST /api/v1/inspections"]
    end

    subgraph L4 [4. Database & Schema Layer]
        DB_WorkOrders[("Table: work_orders")]
        DB_Tasks[("Table: tasks")]
        DB_Inspections[("Table: inspections")]
    end

    subgraph L5 [5. Presentation & Flutter UI Layer]
        UI_WODetail["Screen: WorkOrderDetailScreen"]
        UI_INSDialog["Screen: InspectionChecklistWidget"]
    end

    subgraph L6 [6. Security & Permission Layer]
        PERM_WO_Exec["Permission: WorkOrder.Execute"]
        PERM_INS_Submit["Permission: Inspection.Conduct"]
    end

    subgraph L7 [7. Notification & Event Layer]
        EV_WO_Completed["Event: WorkOrderCompletedEvent"]
        NOTIF_Customer["Notification: Email Customer & Dispatcher"]
    end

    subgraph L8 [8. Offline & Synchronization Layer]
        SYNC_WO_Queue["SyncQueue: PendingWorkOrderCompletion"]
        SYNC_INS_Queue["SyncQueue: PendingInspectionUpload"]
    end

    subgraph L9 [9. Testing & Quality Layer]
        TST_WO_Unit["Unit: CompleteWorkOrderCommandHandlerTests"]
        TST_INS_E2E["E2E: ConductInspectionJourneyTest"]
    end

    %% Relational Connections
    F_WorkOrder --> BR_WO_01
    F_Inspection --> BR_INS_01

    BR_WO_01 --> API_WO_Complete
    BR_INS_01 --> API_INS_Submit

    API_WO_Complete --> DB_WorkOrders
    API_WO_Complete --> DB_Tasks
    API_INS_Submit --> DB_Inspections

    UI_WODetail --> API_WO_Complete
    UI_INSDialog --> API_INS_Submit

    API_WO_Complete -.-> PERM_WO_Exec
    API_INS_Submit -.-> PERM_INS_Submit

    API_WO_Complete --> EV_WO_Completed
    EV_WO_Completed --> NOTIF_Customer

    UI_WODetail --> SYNC_WO_Queue
    UI_INSDialog --> SYNC_INS_Queue
    SYNC_WO_Queue --> API_WO_Complete
    SYNC_INS_Queue --> API_INS_Submit

    API_WO_Complete --- TST_WO_Unit
    UI_INSDialog --- TST_INS_E2E
```

---

## 3. Impact Analysis Traceability Matrix

| Feature / Domain Entity | Primary API Endpoint | Database Table | Flutter UI Screen | Permission Required | Downstream Event / Sync | Target Test Suite |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Work Order Completion** | `POST /api/v1/work-orders/{id}/complete` | `work_orders`, `tasks` | `WorkOrderDetailScreen` | `WorkOrder.Execute` | `WorkOrderCompletedEvent`, `PendingWorkOrderCompletion` | `CompleteWorkOrderCommandHandlerTests` |
| **Asset Inspection** | `POST /api/v1/inspections` | `inspections`, `inspection_items` | `InspectionChecklistScreen` | `Inspection.Conduct` | `InspectionSubmittedEvent`, `PendingInspectionUpload` | `ConductInspectionJourneyTest` |
| **Technician Assignment** | `POST /api/v1/assignments` | `assignments`, `technicians` | `DispatchBoardWidget` | `Dispatch.Manage` | `TechnicianAssignedEvent` | `AssignTechnicianCommandHandlerTests` |
