import 'package:drift/drift.dart';
import 'package:fsp_mobile/core/database/app_database.dart';
import 'package:fsp_mobile/features/work_orders/domain/models/work_order_model.dart';

part 'work_orders_dao.g.dart';

@DriftAccessor(tables: [LocalWorkOrders])
class WorkOrdersDao extends DatabaseAccessor<AppDatabase> with _$WorkOrdersDaoMixin {
  WorkOrdersDao(AppDatabase db) : super(db);

  /// Watch all work orders ordered by createdAt DESC per DEC-WO-003.
  Stream<List<WorkOrderModel>> watchAllWorkOrders() {
    final query = select(localWorkOrders)
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]);
    return query.watch().map((rows) => rows.map(_mapToModel).toList());
  }

  /// Get all work orders (one-shot)
  Future<List<WorkOrderModel>> getAllWorkOrders() async {
    final query = select(localWorkOrders)
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]);
    final rows = await query.get();
    return rows.map(_mapToModel).toList();
  }

  /// Get all pending sync work orders (syncStatus == 1) per DEC-WO-002.
  Future<List<WorkOrderModel>> getPendingSyncItems() async {
    final query = select(localWorkOrders)..where((t) => t.syncStatus.equals(1));
    final rows = await query.get();
    return rows.map(_mapToModel).toList();
  }

  /// Insert or update a work order locally
  Future<int> upsertWorkOrder(Insertable<LocalWorkOrder> order) {
    return into(localWorkOrders).insertOnConflictUpdate(order);
  }

  /// Insert or update from model
  Future<int> insertOrUpdateModel(WorkOrderModel model) {
    return upsertWorkOrder(LocalWorkOrdersCompanion.insert(
      id: model.id,
      tenantId: model.tenantId,
      title: model.title,
      description: model.description,
      status: model.status,
      priority: model.priority,
      createdAt: model.createdAt,
      clientReferenceId: Value(model.clientReferenceId),
      syncStatus: Value(model.syncStatus),
      syncErrorMessage: Value(model.syncErrorMessage),
      rowVersion: Value(model.rowVersion),
    ));
  }

  /// Update sync result after successful server sync
  Future<void> markSynced({
    required String clientReferenceId,
    required String newId,
    required String? rowVersion,
  }) async {
    await (update(localWorkOrders)..where((t) => t.clientReferenceId.equals(clientReferenceId))).write(
      LocalWorkOrdersCompanion(
        id: Value(newId),
        syncStatus: const Value(0),
        syncErrorMessage: const Value(null),
        rowVersion: Value(rowVersion),
      ),
    );
  }

  /// Mark sync error or conflict per DEC-WO-004
  Future<void> markSyncError({
    required String clientReferenceId,
    required int status,
    required String errorMessage,
  }) async {
    await (update(localWorkOrders)..where((t) => t.clientReferenceId.equals(clientReferenceId))).write(
      LocalWorkOrdersCompanion(
        syncStatus: Value(status),
        syncErrorMessage: Value(errorMessage),
      ),
    );
  }

  WorkOrderModel _mapToModel(LocalWorkOrder row) {
    return WorkOrderModel(
      id: row.id,
      tenantId: row.tenantId,
      title: row.title,
      description: row.description,
      status: row.status,
      priority: row.priority,
      createdAt: row.createdAt,
      clientReferenceId: row.clientReferenceId,
      syncStatus: row.syncStatus,
      syncErrorMessage: row.syncErrorMessage,
      rowVersion: row.rowVersion,
    );
  }
}
