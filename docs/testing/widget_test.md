---
title: Flutter Widget & UI State Provider Testing Specifications
category: testing
version: 2.0.0
last_updated: 2026-07-15
---

# FLUTTER WIDGET & UI STATE TESTING

## 1. Riverpod `ConsumerWidget` Testing Rule
Whenever testing a Flutter widget (`WorkOrderListItemWidget`), tests must wrap the widget inside a `ProviderScope` with overridden mock dependencies to ensure deterministic UI rendering:
```dart
testWidgets('WorkOrderListItemWidget displays SLA warning badge when critical', (tester) async {
  // Arrange
  final mockWorkOrder = WorkOrder(id: '1', priority: WorkOrderPriority.critical, status: WorkOrderStatus.assigned);
  
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        workOrderProvider.overrideWith((ref) => AsyncValue.data([mockWorkOrder])),
      ],
      child: const MaterialApp(home: Scaffold(body: WorkOrderListScreen())),
    ),
  );

  // Act
  await tester.pumpAndSettle();

  // Assert
  expect(find.byKey(const Key('sla_critical_badge')), findsOneWidget);
});
```
