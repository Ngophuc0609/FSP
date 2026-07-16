import 'package:fsp_mobile/features/work_orders/domain/models/work_order_model.dart';

/// Repository interface enforcing offline-first reactivity and background sync per ADR-002.
abstract class IWorkOrderRepository {
  /// Streams local work orders from offline SQLite storage for instant UI rendering.
  Stream<List<WorkOrderModel>> watchWorkOrders();

  /// Fetches latest records from remote API and synchronizes local SQLite.
  Future<void> syncWithServer();

  /// Optimistically saves a new work order locally with SyncStatus.pending and triggers remote sync.
  Future<void> createWorkOrder({
    required String title,
    required String description,
    required int priority,
  });

  /// Optimistically updates status or assignment locally and syncs to backend.
  Future<void> assignWorkOrder({
    required String workOrderId,
    required String technicianId,
  });
}
