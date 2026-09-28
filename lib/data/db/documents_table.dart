import 'package:drift/drift.dart';
import 'package:legere/data/models/document_format.dart';

/// Drift table backing the `Document` data class.
/// Column meanings are documented in docs/ARCHITECTURE.md §3.
@DataClassName('Document')
class Documents extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get format => textEnum<DocumentFormat>()();
  TextColumn get filePath => text()();
  TextColumn get coverPath => text().nullable()();
  IntColumn get totalPages => integer().nullable()();
  IntColumn get currentPage => integer().withDefault(const Constant(0))();
  TextColumn get readingPosition => text().nullable()();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get fileSize => integer()();
  DateTimeColumn get importedAt => dateTime()();
  DateTimeColumn get lastOpenedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
