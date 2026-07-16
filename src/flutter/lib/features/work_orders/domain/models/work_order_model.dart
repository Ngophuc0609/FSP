class WorkOrderModel {
  final String id;
  final String tenantId;
  final String title;
  final String description;
  final int status;
  final int priority;
  final DateTime createdAt;
  final String clientReferenceId;
  final int syncStatus; // 0 = Synced, 1 = Pending Sync, 2 = Sync Error
  final String? syncErrorMessage;
  final String? rowVersion;

  const WorkOrderModel({
    required this.id,
    required this.tenantId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.clientReferenceId = '',
    this.syncStatus = 0,
    this.syncErrorMessage,
    this.rowVersion,
  });

  WorkOrderModel copyWith({
    String? id,
    String? tenantId,
    String? title,
    String? description,
    int? status,
    int? priority,
    DateTime? createdAt,
    String? clientReferenceId,
    int? syncStatus,
    String? syncErrorMessage,
    String? rowVersion,
  }) {
    return WorkOrderModel(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      clientReferenceId: clientReferenceId ?? this.clientReferenceId,
      syncStatus: syncStatus ?? this.syncStatus,
      syncErrorMessage: syncErrorMessage ?? this.syncErrorMessage,
      rowVersion: rowVersion ?? this.rowVersion,
    );
  }
}
