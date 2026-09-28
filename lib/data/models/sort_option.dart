/// Sort options for the "Ordenar por" bottom sheet.
/// See docs/features/search-and-filters.md.
enum SortOption {
  titleAsc,
  titleDesc,
  importedNewest,
  importedOldest,
  lastReadNewest,
  favoritesFirst,
}

extension SortOptionX on SortOption {
  /// User-facing Spanish label shown in the sort sheet.
  String get label => switch (this) {
        SortOption.titleAsc => 'Título A-Z',
        SortOption.titleDesc => 'Título Z-A',
        SortOption.importedNewest => 'Más recientes',
        SortOption.importedOldest => 'Más antiguos',
        SortOption.lastReadNewest => 'Últimos leídos',
        SortOption.favoritesFirst => 'Favoritos primero',
      };
}
