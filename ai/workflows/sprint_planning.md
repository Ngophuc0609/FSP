---
id: sprint_planning
title: Multi-Agent Workflow - Sprint Planning & Task Breakdown
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates Business Analyst, Chief Architect, and Domain Leads to decompose PRDs into atomic Work Orders/Tasks.
---

# MULTI-AGENT WORKFLOW: SPRINT PLANNING & TASK BREAKDOWN

This workflow decomposes high-level PRDs (`docs/business/prd.md`) and FSDs into atomic, assignable engineering tasks with clear effort estimates and acceptance criteria (`docs/business/acceptance_criteria.md`).

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: Business Analyst<br/>Extract Epics & Features from PRD] --> B[Step 2: Chief Architect<br/>Decompose into Layered Technical Tasks]
    B --> C[Step 3: Domain Leads<br/>Estimate Story Points & Identify Blockers]
    C --> D{Gate 1: Definition of Ready DoR Check}
    D -- Pass --> E([Sprint Backlog Finalized])
    D -- Fail --> A
```

---

## Detailed Step & Gate Instructions

### Step 1: Feature Extraction (`Business Analyst`)
- **Action:** Review `docs/business/prd.md` and define clear user stories (`As a <persona>, I want <goal>, so that <benefit>`).

### Step 2: Technical Task Decomposition (`Chief Architect`)
- **Action:** Break each feature into exact architectural layers:
  - `[Domain]` Scaffold Entity & Events (`backend_dev.md`)
  - `[Application]` Scaffold MediatR Handlers (`backend_dev.md`)
  - `[Infrastructure]` Scaffold EF Core Config (`db_architect.md`)
  - `[API]` Scaffold Controller & Swagger Spec (`api_designer.md`)
  - `[Flutter]` Scaffold Screen & Riverpod Provider (`flutter_dev.md`)
  - `[QA]` Scaffold Integration Suite (`qa_engineer.md`)

### Step 3: DoR Gate (`QA Lead + Architect`)
- **Gate 1 (Definition of Ready Check):** Every task must have explicit acceptance criteria, zero ambiguous terms, and known upstream dependencies before entering the sprint.
