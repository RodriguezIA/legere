import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/data/models/sort_option.dart';
import 'package:legere/features/library/providers/database_provider.dart';

/// Default sort until Phase 3 wires up the persisted "Ordenar por" choice
/// (docs/features/search-and-filters.md).
const _defaultSort = SortOption.importedNewest;

/// "Biblioteca" tab data (docs/features/library.md).
final libraryDocumentsProvider = StreamProvider.autoDispose<List<Document>>((ref) {
  return ref.watch(documentRepositoryProvider).watchLibrary(sort: _defaultSort);
});

/// "Recientes" tab data: last opened first.
final recentDocumentsProvider = StreamProvider.autoDispose<List<Document>>((ref) {
  return ref.watch(documentRepositoryProvider).watchRecent();
});

/// "Favoritos" tab data.
final favoriteDocumentsProvider = StreamProvider.autoDispose<List<Document>>((ref) {
  return ref.watch(documentRepositoryProvider).watchFavorites(sort: _defaultSort);
});
