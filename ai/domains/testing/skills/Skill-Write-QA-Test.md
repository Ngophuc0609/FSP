---
title: Skill - Write QA Automated Test Suite (xUnit / flutter_test)
category: skill
version: 2.0.0
last_updated: 2026-07-15
---

# SKILL: WRITE QA AUTOMATED TEST SUITE (`Skill-Write-QA-Test`)

## 1. Purpose & Trigger
Use this skill when tasked with generating unit tests (`xUnit`, `NSubstitute`, `FluentAssertions`), widget tests (`flutter_test`), or E2E tests (`Playwright`).

## 2. Execution Steps
1. **Analyze Target Code:** Identify public methods, MediatR handlers, or Riverpod state providers requiring verification.
2. **Scaffold AAA Structure:** Create explicit Arrange, Act, and Assert code blocks.
3. **Inject Mock Dependencies:** Use `NSubstitute` (`Substitute.For<IRepository<WorkOrder>>()`) for unit tests. For integration tests, inject scoped `ITenantProvider` to verify multi-tenant query isolation.
4. **Assert Domain Events:** Verify that target commands raise expected `IDomainEvent` notifications.
