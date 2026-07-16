---
id: testing_context
title: Field Service Platform - Quality & Testing Micro-Context
tier: 2_contexts
domain: testing
version: 2.0.0
last_updated: 2026-07-15
---

# QUALITY & TESTING MICRO-CONTEXT

## 1. Testing Pyramid & Mandatory Coverage
All features built across FSP must satisfy the **Definition of Done (DoD)** with comprehensive automated testing:
- **Unit Testing (.NET Core):** Use `xUnit` + `FluentAssertions` + `NSubstitute`. Every Domain Aggregate, CQRS Command Validator, and MediatR Handler MUST have >= 85% branch coverage.
- **Integration Testing (.NET Core):** Use `WebApplicationFactory<Program>` with `Testcontainers` (SQL Server & Redis containers) to test full API controller-to-database execution pipelines.
- **Unit & Widget Testing (Flutter):** Use `flutter_test` + `mocktail`. Test Riverpod `AsyncNotifier` state transitions (`AsyncLoading` -> `AsyncData`/`AsyncError`) and verify `ConsumerWidget` rendering.

---

## 2. Unit Testing Standards (.NET Core Example)
- **Naming Convention:** `MethodName_StateUnderTest_ExpectedBehavior` (e.g., `AssignTechnicianHandler_WhenTechnicianLacksSkill_ReturnsFailureResult`).
- **Arrange-Act-Assert (AAA):** Strictly separate test phases with clear spacing or comments.
- **No Shared Mutable State:** Every test must instantiate fresh mock repositories or isolated database transactions.

---

## 3. Flutter Riverpod Test Standards
When testing Riverpod providers, always use `ProviderContainer` with explicit overrides:
```dart
test('updateStatus changes WorkOrder status and reloads list', () async {
  final mockRepository = MockWorkOrderRepository();
  when(() => mockRepository.updateStatus(any(), any())).thenAnswer((_) async => {});
  when(() => mockRepository.getAssignedWorkOrders()).thenAnswer((_) async => [mockWorkOrder]);

  final container = ProviderContainer(
    overrides: [workOrderRepositoryProvider.overrideWithValue(mockRepository)],
  );
  addTearDown(container.dispose);

  await container.read(workOrderListProvider.notifier).updateStatus('wo-123', WorkOrderStatus.completed);
  expect(container.read(workOrderListProvider).value!.first.status, WorkOrderStatus.completed);
});
```
