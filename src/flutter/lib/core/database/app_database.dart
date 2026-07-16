import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:fsp_mobile/core/database/daos/work_orders_dao.dart';

part 'app_database.g.dart';

// Drift offline-first table schema for storing WorkOrders locally per RULE-FLUTTER-002 and ADR-003.
class LocalWorkOrders extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get status => integer()();
  IntColumn get priority => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get clientReferenceId => text().withDefault(const Constant(''))();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))(); // 0 = Synced, 1 = Pending Sync, 2 = Sync Error/Conflict
  TextColumn get syncErrorMessage => text().nullable()();
  TextColumn get rowVersion => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [LocalWorkOrders], daos: [WorkOrdersDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fsp_offline.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
