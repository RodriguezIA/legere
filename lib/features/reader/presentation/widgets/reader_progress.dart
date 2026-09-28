/// Callback a format-specific viewer uses to report reading progress up to
/// [ReaderScreen]. [currentPage] and [totalPages] are 0-based/absolute counts;
/// [position] carries a format-specific locator (epub) when applicable.
/// See docs/features/reader.md "Progress persistence".
typedef ReaderProgressCallback = void Function({
  required int currentPage,
  required int totalPages,
  String? position,
});
