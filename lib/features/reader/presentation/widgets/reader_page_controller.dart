import 'package:flutter/widgets.dart';

/// Minimal, format-agnostic handle so [ReaderScreen]'s footer prev/next
/// buttons can drive whichever page controller a viewer uses internally
/// (pdfx's `PdfController` for pdf, Flutter's `PageController` for the rest).
class ReaderPageController {
  const ReaderPageController({required this.nextPage, required this.previousPage});

  final VoidCallback nextPage;
  final VoidCallback previousPage;
}
