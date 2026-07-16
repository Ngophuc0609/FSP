---
id: generate_tests
title: Multi-Agent Workflow - Comprehensive Test Suite Generation
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates QA Lead and Domain Personas to generate Unit, Integration, and E2E test suites with high coverage.
---

# MULTI-AGENT WORKFLOW: COMPREHENSIVE TEST SUITE GENERATION

This workflow coordinates `QA Automation Lead` and Domain Developers to produce complete test coverage (`AAA` pattern, containerized integration tests, and edge case matrices).

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: QA Automation Lead<br/>Formulate Test Matrix & Plan] --> B[Step 2: Domain Developer<br/>Scaffold Unit & Mock Tests]
    B --> C[Step 3: QA Automation Lead<br/>Scaffold Integration & Testcontainers Suite]
    C --> D{Gate 1: 100% Pass & Tenant Isolation Verified?}
    D -- Pass --> E([Test Suite Finalized])
    D -- Fail --> C
```

---

## Detailed Step & Gate Instructions

### Step 1: Test Plan & Matrix (`QA Automation Lead`)
- **Action:** Activate `generate_test_plan.md` to create happy path, boundary, and negative scenarios.

### Step 2: Unit Suite Scaffolding (`Domain Developer`)
- **Action:** Scaffold `AAA` unit tests (`xUnit` + `NSubstitute` for .NET; `mocktail` for Dart).

### Step 3: Integration & Multi-Tenant Suite (`QA Automation Lead`)
- **Action:** Scaffold containerized integration tests verifying database queries with explicit `TenantId` filters.
- **Gate 1 (Coverage & Isolation Check):** All suites must run cleanly and verify multi-tenant isolation.
