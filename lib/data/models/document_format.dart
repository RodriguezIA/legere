/// Supported document formats. Stored in the database as the enum name.
///
/// See docs/PLAN.md §4 for the open-source support strategy per format —
/// [cbr] and [mobi] are scheduled last (Phase 6) as a feasibility spike.
enum DocumentFormat { epub, pdf, cbz, cbr, mobi, txt }

extension DocumentFormatX on DocumentFormat {
  /// Short label shown as the tag overlaid on a document's cover.
  String get label => switch (this) {
        DocumentFormat.epub => 'EPUB',
        DocumentFormat.pdf => 'PDF',
        DocumentFormat.cbz => 'CBZ',
        DocumentFormat.cbr => 'CBR',
        DocumentFormat.mobi => 'MOBI',
        DocumentFormat.txt => 'TXT',
      };

  /// File extensions (without the dot) recognized as this format.
  List<String> get extensions => switch (this) {
        DocumentFormat.epub => const ['epub'],
        DocumentFormat.pdf => const ['pdf'],
        DocumentFormat.cbz => const ['cbz'],
        DocumentFormat.cbr => const ['cbr'],
        DocumentFormat.mobi => const ['mobi'],
        DocumentFormat.txt => const ['txt'],
      };
}

/// Resolves a [DocumentFormat] from a file extension (case-insensitive),
/// or `null` if unsupported.
DocumentFormat? documentFormatFromExtension(String extension) {
  final normalized = extension.toLowerCase().replaceFirst('.', '');
  for (final format in DocumentFormat.values) {
    if (format.extensions.contains(normalized)) return format;
  }
  return null;
}
