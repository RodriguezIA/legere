/// Metadata pulled from a document at import time.
/// See docs/features/import.md step 3.
class ExtractedMetadata {
  const ExtractedMetadata({
    required this.title,
    this.author,
    this.totalPages,
  });

  final String title;
  final String? author;

  /// Known page count, if determinable at import time. `null` for formats
  /// (epub, txt) whose pagination depends on the reader's viewport/font size.
  final int? totalPages;
}
