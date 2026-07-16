---
ontology_id: ONT-TST-001
category: Testing Domain Vocabulary
status: Active
version: 1.0.0
owner: QA & Automation Domain Lead
last_updated: 2026-07-15
terms:
  - id: TRM-TST-001
    term: Unit Test
    definition: "An automated test verifying the functional behavior of a single class, method, or pure domain entity in total isolation from external infrastructure using mocks or stubs."
    attributes: [target_class, test_method, arrange_act_assert, coverage_percentage]

  - id: TRM-TST-002
    term: Integration Test
    definition: "An automated test verifying the communication and contract fulfillment between multiple application components, databases, or external API endpoints."
    attributes: [test_environment, database_fixture, external_dependencies, assertions]

  - id: TRM-TST-003
    term: End-to-End (E2E) Test
    definition: "A high-level automated test executing complete user journeys from the presentation layer through the backend services and persistence layers."
    attributes: [user_journey, test_scenario, ui_driver, test_data_cleanup]

  - id: TRM-TST-004
    term: Widget Test
    definition: "A Flutter-specific test verifying the layout, rendering, and interaction behavior of a single UI widget or composed widget tree in a simulated environment."
    attributes: [widget_under_test, widget_tester, finder, interaction_events]

  - id: TRM-TST-005
    term: Mocking & Stubbing
    definition: "The practice of replacing real infrastructure dependencies (such as repositories or HTTP clients) with controlled test doubles returning deterministic responses."
    attributes: [mock_library, setup_expectations, verification_calls]

  - id: TRM-TST-006
    term: Test Plan
    definition: "A structured QA specification outlining test scope, risk assessment, automated test cases, and quality criteria for a feature delivery."
    attributes: [feature_id, risk_level, test_cases, regression_scope]
---

# Testing Ontology & Quality Assurance Vocabulary

## Overview
This file establishes canonical QA terminology and testing patterns across FSP. AI QA agents (`qa_engineer`, `automation_tester`, `security_tester`) and developers must use these definitions when writing test plans, generating test suites, or evaluating test coverage.

## Testing Hierarchy & Pyramid Standard

```text
       / \
      /E2E\      <- End-to-End & UI Journey Tests (10%)
     /-----\
    / Integ \    <- API & Database Integration Tests (30%)
   /---------\
  /   Unit    \  <- Domain Entity, MediatR Handler & BLoC Tests (60%)
 /-------------\
```

### 1. Unit Testing Rules
- Every MediatR Command/Query Handler and Flutter BLoC MUST have 100% unit test coverage for happy paths and domain error conditions.
- Unit tests must execute in under 50 milliseconds each and require zero external configuration or database connections.

### 2. Naming Convention for Test Cases
Test methods must clearly articulate the scenario being verified using the pattern:
`[MethodUnderTest]_[Scenario/Condition]_[ExpectedBehavior]`
Example: `AssignTechnician_WhenTechnicianIsAlreadyEnRoute_ReturnsResultFailure`
