import 'package:drift/drift.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/data/models/document_format.dart';
import 'package:legere/data/models/sort_option.dart';

/// Single source of truth for reading/writing [Document] rows.
///
/// Query shapes mirror docs/ARCHITECTURE.md §3 (Biblioteca / Recientes /
/// Favoritos / Search). UI code should go through this repository rather than
/// touching [AppDatabase] directly (see docs/ARCHITECTURE.md §6).
class DocumentRepository {
  DocumentRepository(this._db);

  final AppDatabase _db;

  /// "Biblioteca" tab: all documents, filtered by [query] and ordered by [sort].
  Stream<List<Document>> watchLibrary({String query = '', required SortOption sort}) {
    final selectQuery = _db.select(_db.documents)
      ..where((t) => _searchPredicate(t, query))
      ..orderBy(_orderingFor(sort));
    return selectQuery.watch();
  }

  /// "Recientes" tab: only opened documents, last opened first. Ignores [sort]
  /// by design (docs/features/search-and-filters.md).
  Stream<List<Document>> watchRecent({String query = ''}) {
    final selectQuery = _db.select(_db.documents)
      ..where((t) => t.lastOpenedAt.isNotNull() & _searchPredicate(t, query))
      ..orderBy([(t) => OrderingTerm.desc(t.lastOpenedAt)]);
    return selectQuery.watch();
  }

  /// "Favoritos" tab: only favorites, filtered by [query] and ordered by [sort].
  Stream<List<Document>> watchFavorites({String query = '', required SortOption sort}) {
    final selectQuery = _db.select(_db.documents)
      ..where((t) => t.isFavorite.equals(true) & _searchPredicate(t, query))
      ..orderBy(_orderingFor(sort));
    return selectQuery.watch();
  }

  Future<Document?> getById(String id) =>
      (_db.select(_db.documents)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<String> insertDocument(DocumentsCompanion entry) async {
    await _db.into(_db.documents).insert(entry);
    return entry.id.value;
  }

  Future<void> setFavorite(String id, bool isFavorite) =>
      _updateById(id, DocumentsCompanion(isFavorite: Value(isFavorite)));

  Future<void> markOpened(String id) =>
      _updateById(id, DocumentsCompanion(lastOpenedAt: Value(DateTime.now())));

  /// Persists reading progress. [page] is the page index for paginated formats;
  /// [position] is the epub locator/CFI when applicable (see ARCHITECTURE.md §5).
  Future<void> saveProgress(
    String id, {
    required int currentPage,
    required double progress,
    String? position,
  }) =>
      _updateById(
        id,
        DocumentsCompanion(
          currentPage: Value(currentPage),
          progress: Value(progress),
          readingPosition: Value(position),
        ),
      );

  Future<void> deleteDocument(String id) =>
      (_db.delete(_db.documents)..where((t) => t.id.equals(id))).go();

  Future<void> _updateById(String id, DocumentsCompanion entry) =>
      (_db.update(_db.documents)..where((t) => t.id.equals(id))).write(entry);

  Expression<bool> _searchPredicate($DocumentsTable t, String query) {
    if (query.isEmpty) return const Constant(true);
    final like = '%$query%';
    final matchingFormats = DocumentFormat.values.where(
      (f) => f.label.toLowerCase().contains(query.toLowerCase()) ||
          f.name.toLowerCase().contains(query.toLowerCase()),
    );
    return t.title.like(like) |
        t.author.like(like) |
        (matchingFormats.isEmpty
            ? const Constant(false)
            : t.format.isInValues(matchingFormats));
  }

  List<OrderingTerm Function($DocumentsTable)> _orderingFor(SortOption sort) {
    switch (sort) {
      case SortOption.titleAsc:
        return [(t) => OrderingTerm.asc(t.title)];
      case SortOption.titleDesc:
        return [(t) => OrderingTerm.desc(t.title)];
      case SortOption.importedNewest:
        return [(t) => OrderingTerm.desc(t.importedAt)];
      case SortOption.importedOldest:
        return [(t) => OrderingTerm.asc(t.importedAt)];
      case SortOption.lastReadNewest:
        return [(t) => OrderingTerm.desc(t.lastOpenedAt)];
      case SortOption.favoritesFirst:
        return [
          (t) => OrderingTerm.desc(t.isFavorite),
          (t) => OrderingTerm.asc(t.title),
        ];
    }
  }
}
