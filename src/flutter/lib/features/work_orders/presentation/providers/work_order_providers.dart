import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsp_mobile/core/database/app_database.dart';
import 'package:fsp_mobile/core/network/api_client.dart';
import 'package:fsp_mobile/features/work_orders/domain/models/work_order_model.dart';
import 'package:fsp_mobile/features/work_orders/domain/repositories/i_work_order_repository.dart';
import 'package:fsp_mobile/features/work_orders/data/repositories/work_order_repository_impl.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: 'https://api.fsp.local', tenantId: 'TENANT-ALPHA');
});

final workOrderRepositoryProvider = Provider<IWorkOrderRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final db = ref.watch(appDatabaseProvider);
  return WorkOrderRepositoryImpl(apiClient: apiClient, dao: db.workOrdersDao);
});

/// Riverpod AsyncNotifier provider managing reactive WorkOrder state and background sync per DEC-WO-003.
final workOrderListNotifierProvider = AsyncNotifierProvider<WorkOrderListNotifier, List<WorkOrderModel>>(() {
  return WorkOrderListNotifier();
});

class WorkOrderListNotifier extends AsyncNotifier<List<WorkOrderModel>> {
  @override
  Future<List<WorkOrderModel>> build() async {
    final repository = ref.watch(workOrderRepositoryProvider);
    
    // Listen to continuous stream from repository
    repository.watchWorkOrders().listen((items) {
      state = AsyncValue.data(items);
    });

    // Initial background sync check
    repository.syncWithServer();

    return [];
  }

  Future<void> createWorkOrder({
    required String title,
    required String description,
    required int priority,
  }) async {
    final repository = ref.read(workOrderRepositoryProvider);
    await repository.createWorkOrder(title: title, description: description, priority: priority);
  }

  Future<void> refreshSync() async {
    final repository = ref.read(workOrderRepositoryProvider);
    await repository.syncWithServer();
  }
}
