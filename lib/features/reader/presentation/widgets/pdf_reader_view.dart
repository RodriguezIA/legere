import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import 'package:legere/features/reader/presentation/widgets/reader_page_controller.dart';
import 'package:legere/features/reader/presentation/widgets/reader_progress.dart';

/// PDF viewer (docs/features/reader.md "pdf: pdfx page view").
class PdfReaderView extends StatefulWidget {
  const PdfReaderView({
    super.key,
    required this.filePath,
    required this.initialPage,
    required this.onProgress,
    this.onControllerReady,
  });

  final String filePath;

  /// 0-based initial page.
  final int initialPage;
  final ReaderProgressCallback onProgress;
  final void Function(ReaderPageController)? onControllerReady;

  @override
  State<PdfReaderView> createState() => _PdfReaderViewState();
}

class _PdfReaderViewState extends State<PdfReaderView> {
  late final PdfController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfController(
      document: PdfDocument.openFile(widget.filePath),
      initialPage: widget.initialPage + 1,
    );
    _controller.document.then((doc) {
      if (!mounted) return;
      widget.onProgress(currentPage: widget.initialPage, totalPages: doc.pagesCount);
    });
    widget.onControllerReady?.call(
      ReaderPageController(
        nextPage: () => _controller.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        previousPage: () => _controller.previousPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: _controller,
      onPageChanged: (page) async {
        final doc = await _controller.document;
        widget.onProgress(currentPage: page - 1, totalPages: doc.pagesCount);
      },
    );
  }
}
