---
id: flutter_context
title: Field Service Platform - Flutter Mobile Micro-Context
tier: 2_contexts
domain: flutter
version: 2.0.0
last_updated: 2026-07-15
---

# FLUTTER MOBILE ENGINEERING MICRO-CONTEXT (FLUTTER 3.X+)

## 1. Architectural Stack & Layering
The Field Technician mobile app is built using **Flutter 3.x (Dart 3.x)** adhering to **Feature-First Domain Layering** and **Riverpod 2.x**.
Folder structure inside `src/` must follow:
- `features/<feature_name>/domain/`: Models (`Freezed`), Entities, and Repository Interfaces (`IWorkOrderRepository`). Zero Flutter UI dependencies.
- `features/<feature_name>/data/`: Repository Implementations, Remote Data Sources (`Dio`), and Local SQLite Data Sources (`Drift`).
- `features/<feature_name>/presentation/`: Riverpod Providers (`AsyncNotifierProvider`, `StateNotifierProvider`), Screens (`ConsumerWidget`), and Widgets.

---

## 2. Riverpod 2.x State Management Standards
- **Never use `StateProvider` for complex asynchronous operations.** Always use `AsyncNotifierProvider` or `AutoDisposeAsyncNotifierProvider`.
- **Never perform direct HTTP calls inside UI Widgets.** UI widgets must call `ref.read(provider.notifier).executeAction()` or watch `ref.watch(provider)`.
- **State Immutability:** All state objects must be generated using `Freezed` with `@freezed` annotation to ensure complete immutability (`copyWith`).

### Riverpod AsyncNotifier Pattern
```dart
@riverpod
class WorkOrderList extends _$WorkOrderList {
  @override
  FutureOr<List<WorkOrder>> build() async {
    final repository = ref.watch(workOrderRepositoryProvider);
    return repository.getAssignedWorkOrders();
  }

  Future<void> updateStatus(String workOrderId, WorkOrderStatus newStatus) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(workOrderRepositoryProvider);
      await repository.updateStatus(workOrderId, newStatus);
      return repository.getAssignedWorkOrders();
    });
  }
}
```

---

## 3. Offline-First Sync & Local Storage (Drift/SQLite)
- Every remote domain entity (`WorkOrder`, `Asset`, `Checklist`) MUST have a corresponding Drift SQLite table representation for local offline caching.
- When saving mutations offline (e.g. technician signature or checklist check), write immediately to the local Drift table with `is_dirty = 1` and append an entry to `outbox_sync_queue`.
- A background sync worker (`Workmanager` / custom stream) will drain `outbox_sync_queue` when network connectivity is restored.
