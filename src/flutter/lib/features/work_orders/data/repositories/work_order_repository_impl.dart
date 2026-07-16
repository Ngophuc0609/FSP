import 'dart:async';
import 'package:fsp_mobile/core/database/daos/work_orders_dao.dart';
import 'package:fsp_mobile/core/network/api_client.dart';
import 'package:fsp_mobile/features/work_orders/domain/models/work_order_model.dart';
import 'package:fsp_mobile/features/work_orders/domain/repositories/i_work_order_repository.dart';

/// Offline-first repository implementation powered by Drift SQLite and Dio synchronization.
/// Implements DEC-WO-002 clientReferenceId deduplication and DEC-WO-004 RowVersion 409 conflict handling per ADR-003.
class WorkOrderRepositoryImpl implements IWorkOrderRepository {
  final ApiClient _apiClient;
  final WorkOrdersDao _dao;

  WorkOrderRepositoryImpl({required ApiClient apiClient, required WorkOrdersDao dao})
      : _apiClient = apiClient,
        _dao = dao;

  @override
  Stream<List<WorkOrderModel>> watchWorkOrders() {
    return _dao.watchAllWorkOrders();
  }

  @override
  Future<void> syncWithServer() async {
    try {
      // 1. Sync pending local items to backend API per DEC-WO-002 (clientReferenceId deduplication)
      final pendingItems = await _dao.getPendingSyncItems();
      for (final item in pendingItems) {
        try {
          final response = await _apiClient.client.post(
            '/api/v1/work-orders',
            data: {
              'title': item.title,
              'description': item.description,
              'priority': item.priority,
              'clientReferenceId': item.clientReferenceId,
              'rowVersion': item.rowVersion,
            },
          );
          if (response.statusCode == 201 || response.statusCode == 200) {
            final data = response.data;
            final realId = (data is Map && data['id'] != null) ? data['id'].toString() : item.id;
            final rowVersion = (data is Map && data['rowVersion'] != null) ? data['rowVersion'].toString() : null;
            await _dao.markSynced(
              clientReferenceId: item.clientReferenceId,
              newId: realId,
              rowVersion: rowVersion,
            );
          }
        } catch (e) {
          // Check for 409 Conflict per DEC-WO-004
          if (e.toString().contains('409') || (e.toString().contains('status code of 409'))) {
            await _dao.markSyncError(
              clientReferenceId: item.clientReferenceId,
              status: 2, // Conflict status per DEC-WO-004
              errorMessage: 'Xung đột phiên bản dữ liệu (RowVersion 409 Conflict). Vui lòng tải lại và thử lại.',
            );
          } else {
            // Retain pending status = 1 for exponential backoff retry on connection timeout / 5xx
          }
        }
      }

      // 2. Fetch remote keyset items from server per DEC-WO-003
      try {
        final response = await _apiClient.client.get('/api/v1/work-orders', queryParameters: {'pageSize': 20});
        if (response.statusCode == 200 && response.data != null) {
          final items = response.data;
          if (items is List) {
            for (final map in items) {
              if (map is Map<String, dynamic>) {
                final clientRef = map['clientReferenceId']?.toString() ?? '';
                final remoteItem = WorkOrderModel(
                  id: map['id']?.toString() ?? '',
                  tenantId: map['tenantId']?.toString() ?? _apiClient.tenantId,
                  title: map['title']?.toString() ?? '',
                  description: map['description']?.toString() ?? '',
                  status: int.tryParse(map['status']?.toString() ?? '0') ?? 0,
                  priority: int.tryParse(map['priority']?.toString() ?? '0') ?? 0,
                  createdAt: DateTime.tryParse(map['createdAtUtc']?.toString() ?? '') ?? DateTime.now(),
                  clientReferenceId: clientRef,
                  syncStatus: 0,
                  rowVersion: map['rowVersion']?.toString(),
                );
                await _dao.insertOrUpdateModel(remoteItem);
              }
            }
          }
        }
      } catch (_) {
        // Retain local Drift SQLite data on cellular disconnect per RULE-FLUTTER-002
      }
    } catch (_) {
      // Safe offline fallback
    }
  }

  @override
  Future<void> createWorkOrder({
    required String title,
    required String description,
    required int priority,
  }) async {
    final clientRef = 'WO-REF-${DateTime.now().millisecondsSinceEpoch}-${DateTime.now().microsecond}';
    final newItem = WorkOrderModel(
      id: 'WO-LOCAL-${DateTime.now().millisecondsSinceEpoch}',
      tenantId: _apiClient.tenantId,
      title: title,
      description: description,
      status: 0, // Draft
      priority: priority,
      createdAt: DateTime.now(),
      clientReferenceId: clientRef,
      syncStatus: 1, // Pending Sync per DEC-WO-002
    );

    // 1. Instant offline insertion into SQLite (triggers automatic stream update for UI)
    await _dao.insertOrUpdateModel(newItem);

    // 2. Trigger non-blocking background synchronization per ADR-002
    unawaited(syncWithServer());
  }

  @override
  Future<void> assignWorkOrder({required String workOrderId, required String technicianId}) async {
    final all = await _dao.getAllWorkOrders();
    final idx = all.indexWhere((item) => item.id == workOrderId);
    if (idx != -1) {
      final updated = all[idx].copyWith(
        status: 1, // Assigned
        syncStatus: 1, // Mark for background sync
      );
      await _dao.insertOrUpdateModel(updated);
      unawaited(syncWithServer());
    }
  }

  void unawaited(Future<void> future) {
    future.catchError((_) {});
  }
}
