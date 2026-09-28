import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:legere/data/models/document_format.dart';

import 'documents_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Documents])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Testing-only constructor to inject an in-memory/custom executor.
  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'legere_db',
    native: DriftNativeOptions(
      databaseDirectory: getApplicationDocumentsDirectory,
    ),
  );
}
