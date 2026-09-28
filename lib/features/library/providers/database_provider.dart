import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/data/repositories/document_repository.dart';

/// App-wide Drift database instance. Closed automatically when disposed.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// The single [DocumentRepository] instance the whole app reads/writes
/// through (see docs/ARCHITECTURE.md §6).
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepository(ref.watch(appDatabaseProvider));
});
