// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalWorkOrdersTable extends LocalWorkOrders
    with TableInfo<$LocalWorkOrdersTable, LocalWorkOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWorkOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _clientReferenceIdMeta =
      const VerificationMeta('clientReferenceId');
  @override
  late final GeneratedColumn<String> clientReferenceId =
      GeneratedColumn<String>('client_reference_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _syncErrorMessageMeta =
      const VerificationMeta('syncErrorMessage');
  @override
  late final GeneratedColumn<String> syncErrorMessage = GeneratedColumn<String>(
      'sync_error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rowVersionMeta =
      const VerificationMeta('rowVersion');
  @override
  late final GeneratedColumn<String> rowVersion = GeneratedColumn<String>(
      'row_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        title,
        description,
        status,
        priority,
        createdAt,
        clientReferenceId,
        syncStatus,
        syncErrorMessage,
        rowVersion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_work_orders';
  @override
  VerificationContext validateIntegrity(Insertable<LocalWorkOrder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('client_reference_id')) {
      context.handle(
          _clientReferenceIdMeta,
          clientReferenceId.isAcceptableOrUnknown(
              data['client_reference_id']!, _clientReferenceIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('sync_error_message')) {
      context.handle(
          _syncErrorMessageMeta,
          syncErrorMessage.isAcceptableOrUnknown(
              data['sync_error_message']!, _syncErrorMessageMeta));
    }
    if (data.containsKey('row_version')) {
      context.handle(
          _rowVersionMeta,
          rowVersion.isAcceptableOrUnknown(
              data['row_version']!, _rowVersionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalWorkOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWorkOrder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      clientReferenceId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_reference_id'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_status'])!,
      syncErrorMessage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sync_error_message']),
      rowVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}row_version']),
    );
  }

  @override
  $LocalWorkOrdersTable createAlias(String alias) {
    return $LocalWorkOrdersTable(attachedDatabase, alias);
  }
}

class LocalWorkOrder extends DataClass implements Insertable<LocalWorkOrder> {
  final String id;
  final String tenantId;
  final String title;
  final String description;
  final int status;
  final int priority;
  final DateTime createdAt;
  final String clientReferenceId;
  final int syncStatus;
  final String? syncErrorMessage;
  final String? rowVersion;
  const LocalWorkOrder(
      {required this.id,
      required this.tenantId,
      required this.title,
      required this.description,
      required this.status,
      required this.priority,
      required this.createdAt,
      required this.clientReferenceId,
      required this.syncStatus,
      this.syncErrorMessage,
      this.rowVersion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['status'] = Variable<int>(status);
    map['priority'] = Variable<int>(priority);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['client_reference_id'] = Variable<String>(clientReferenceId);
    map['sync_status'] = Variable<int>(syncStatus);
    if (!nullToAbsent || syncErrorMessage != null) {
      map['sync_error_message'] = Variable<String>(syncErrorMessage);
    }
    if (!nullToAbsent || rowVersion != null) {
      map['row_version'] = Variable<String>(rowVersion);
    }
    return map;
  }

  LocalWorkOrdersCompanion toCompanion(bool nullToAbsent) {
    return LocalWorkOrdersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      title: Value(title),
      description: Value(description),
      status: Value(status),
      priority: Value(priority),
      createdAt: Value(createdAt),
      clientReferenceId: Value(clientReferenceId),
      syncStatus: Value(syncStatus),
      syncErrorMessage: syncErrorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(syncErrorMessage),
      rowVersion: rowVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(rowVersion),
    );
  }

  factory LocalWorkOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWorkOrder(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      status: serializer.fromJson<int>(json['status']),
      priority: serializer.fromJson<int>(json['priority']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      clientReferenceId: serializer.fromJson<String>(json['clientReferenceId']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      syncErrorMessage: serializer.fromJson<String?>(json['syncErrorMessage']),
      rowVersion: serializer.fromJson<String?>(json['rowVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'status': serializer.toJson<int>(status),
      'priority': serializer.toJson<int>(priority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'clientReferenceId': serializer.toJson<String>(clientReferenceId),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'syncErrorMessage': serializer.toJson<String?>(syncErrorMessage),
      'rowVersion': serializer.toJson<String?>(rowVersion),
    };
  }

  LocalWorkOrder copyWith(
          {String? id,
          String? tenantId,
          String? title,
          String? description,
          int? status,
          int? priority,
          DateTime? createdAt,
          String? clientReferenceId,
          int? syncStatus,
          Value<String?> syncErrorMessage = const Value.absent(),
          Value<String?> rowVersion = const Value.absent()}) =>
      LocalWorkOrder(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        createdAt: createdAt ?? this.createdAt,
        clientReferenceId: clientReferenceId ?? this.clientReferenceId,
        syncStatus: syncStatus ?? this.syncStatus,
        syncErrorMessage: syncErrorMessage.present
            ? syncErrorMessage.value
            : this.syncErrorMessage,
        rowVersion: rowVersion.present ? rowVersion.value : this.rowVersion,
      );
  LocalWorkOrder copyWithCompanion(LocalWorkOrdersCompanion data) {
    return LocalWorkOrder(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      clientReferenceId: data.clientReferenceId.present
          ? data.clientReferenceId.value
          : this.clientReferenceId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      syncErrorMessage: data.syncErrorMessage.present
          ? data.syncErrorMessage.value
          : this.syncErrorMessage,
      rowVersion:
          data.rowVersion.present ? data.rowVersion.value : this.rowVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWorkOrder(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('clientReferenceId: $clientReferenceId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncErrorMessage: $syncErrorMessage, ')
          ..write('rowVersion: $rowVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      title,
      description,
      status,
      priority,
      createdAt,
      clientReferenceId,
      syncStatus,
      syncErrorMessage,
      rowVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWorkOrder &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.createdAt == this.createdAt &&
          other.clientReferenceId == this.clientReferenceId &&
          other.syncStatus == this.syncStatus &&
          other.syncErrorMessage == this.syncErrorMessage &&
          other.rowVersion == this.rowVersion);
}

class LocalWorkOrdersCompanion extends UpdateCompanion<LocalWorkOrder> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> title;
  final Value<String> description;
  final Value<int> status;
  final Value<int> priority;
  final Value<DateTime> createdAt;
  final Value<String> clientReferenceId;
  final Value<int> syncStatus;
  final Value<String?> syncErrorMessage;
  final Value<String?> rowVersion;
  final Value<int> rowid;
  const LocalWorkOrdersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.clientReferenceId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncErrorMessage = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalWorkOrdersCompanion.insert({
    required String id,
    required String tenantId,
    required String title,
    required String description,
    required int status,
    required int priority,
    required DateTime createdAt,
    this.clientReferenceId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncErrorMessage = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        title = Value(title),
        description = Value(description),
        status = Value(status),
        priority = Value(priority),
        createdAt = Value(createdAt);
  static Insertable<LocalWorkOrder> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? status,
    Expression<int>? priority,
    Expression<DateTime>? createdAt,
    Expression<String>? clientReferenceId,
    Expression<int>? syncStatus,
    Expression<String>? syncErrorMessage,
    Expression<String>? rowVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (createdAt != null) 'created_at': createdAt,
      if (clientReferenceId != null) 'client_reference_id': clientReferenceId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncErrorMessage != null) 'sync_error_message': syncErrorMessage,
      if (rowVersion != null) 'row_version': rowVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalWorkOrdersCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? title,
      Value<String>? description,
      Value<int>? status,
      Value<int>? priority,
      Value<DateTime>? createdAt,
      Value<String>? clientReferenceId,
      Value<int>? syncStatus,
      Value<String?>? syncErrorMessage,
      Value<String?>? rowVersion,
      Value<int>? rowid}) {
    return LocalWorkOrdersCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (clientReferenceId.present) {
      map['client_reference_id'] = Variable<String>(clientReferenceId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (syncErrorMessage.present) {
      map['sync_error_message'] = Variable<String>(syncErrorMessage.value);
    }
    if (rowVersion.present) {
      map['row_version'] = Variable<String>(rowVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalWorkOrdersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('clientReferenceId: $clientReferenceId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncErrorMessage: $syncErrorMessage, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalWorkOrdersTable localWorkOrders =
      $LocalWorkOrdersTable(this);
  late final WorkOrdersDao workOrdersDao = WorkOrdersDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localWorkOrders];
}

typedef $$LocalWorkOrdersTableCreateCompanionBuilder = LocalWorkOrdersCompanion
    Function({
  required String id,
  required String tenantId,
  required String title,
  required String description,
  required int status,
  required int priority,
  required DateTime createdAt,
  Value<String> clientReferenceId,
  Value<int> syncStatus,
  Value<String?> syncErrorMessage,
  Value<String?> rowVersion,
  Value<int> rowid,
});
typedef $$LocalWorkOrdersTableUpdateCompanionBuilder = LocalWorkOrdersCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> title,
  Value<String> description,
  Value<int> status,
  Value<int> priority,
  Value<DateTime> createdAt,
  Value<String> clientReferenceId,
  Value<int> syncStatus,
  Value<String?> syncErrorMessage,
  Value<String?> rowVersion,
  Value<int> rowid,
});

class $$LocalWorkOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalWorkOrdersTable> {
  $$LocalWorkOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientReferenceId => $composableBuilder(
      column: $table.clientReferenceId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncErrorMessage => $composableBuilder(
      column: $table.syncErrorMessage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rowVersion => $composableBuilder(
      column: $table.rowVersion, builder: (column) => ColumnFilters(column));
}

class $$LocalWorkOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalWorkOrdersTable> {
  $$LocalWorkOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientReferenceId => $composableBuilder(
      column: $table.clientReferenceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncErrorMessage => $composableBuilder(
      column: $table.syncErrorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rowVersion => $composableBuilder(
      column: $table.rowVersion, builder: (column) => ColumnOrderings(column));
}

class $$LocalWorkOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalWorkOrdersTable> {
  $$LocalWorkOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get clientReferenceId => $composableBuilder(
      column: $table.clientReferenceId, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get syncErrorMessage => $composableBuilder(
      column: $table.syncErrorMessage, builder: (column) => column);

  GeneratedColumn<String> get rowVersion => $composableBuilder(
      column: $table.rowVersion, builder: (column) => column);
}

class $$LocalWorkOrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalWorkOrdersTable,
    LocalWorkOrder,
    $$LocalWorkOrdersTableFilterComposer,
    $$LocalWorkOrdersTableOrderingComposer,
    $$LocalWorkOrdersTableAnnotationComposer,
    $$LocalWorkOrdersTableCreateCompanionBuilder,
    $$LocalWorkOrdersTableUpdateCompanionBuilder,
    (
      LocalWorkOrder,
      BaseReferences<_$AppDatabase, $LocalWorkOrdersTable, LocalWorkOrder>
    ),
    LocalWorkOrder,
    PrefetchHooks Function()> {
  $$LocalWorkOrdersTableTableManager(
      _$AppDatabase db, $LocalWorkOrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWorkOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalWorkOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalWorkOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> clientReferenceId = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<String?> syncErrorMessage = const Value.absent(),
            Value<String?> rowVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalWorkOrdersCompanion(
            id: id,
            tenantId: tenantId,
            title: title,
            description: description,
            status: status,
            priority: priority,
            createdAt: createdAt,
            clientReferenceId: clientReferenceId,
            syncStatus: syncStatus,
            syncErrorMessage: syncErrorMessage,
            rowVersion: rowVersion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String title,
            required String description,
            required int status,
            required int priority,
            required DateTime createdAt,
            Value<String> clientReferenceId = const Value.absent(),
            Value<int> syncStatus = const Value.absent(),
            Value<String?> syncErrorMessage = const Value.absent(),
            Value<String?> rowVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalWorkOrdersCompanion.insert(
            id: id,
            tenantId: tenantId,
            title: title,
            description: description,
            status: status,
            priority: priority,
            createdAt: createdAt,
            clientReferenceId: clientReferenceId,
            syncStatus: syncStatus,
            syncErrorMessage: syncErrorMessage,
            rowVersion: rowVersion,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalWorkOrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalWorkOrdersTable,
    LocalWorkOrder,
    $$LocalWorkOrdersTableFilterComposer,
    $$LocalWorkOrdersTableOrderingComposer,
    $$LocalWorkOrdersTableAnnotationComposer,
    $$LocalWorkOrdersTableCreateCompanionBuilder,
    $$LocalWorkOrdersTableUpdateCompanionBuilder,
    (
      LocalWorkOrder,
      BaseReferences<_$AppDatabase, $LocalWorkOrdersTable, LocalWorkOrder>
    ),
    LocalWorkOrder,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalWorkOrdersTableTableManager get localWorkOrders =>
      $$LocalWorkOrdersTableTableManager(_db, _db.localWorkOrders);
}
