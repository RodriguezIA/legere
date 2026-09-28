import 'dart:io';

import 'package:flutter/material.dart';

import 'package:legere/features/reader/presentation/widgets/reader_page_controller.dart';
import 'package:legere/features/reader/presentation/widgets/reader_progress.dart';

/// Plain-text viewer with simple fixed-size pagination.
/// See docs/features/reader.md "txt: custom paginator over the text".
///
/// Pagination is approximate (chunked by character count) rather than
/// viewport-exact; refining it against the actual rendered layout is a
/// Phase 5 polish item (docs/PLAN.md).
class TxtReaderView extends StatefulWidget {
  const TxtReaderView({
    super.key,
    required this.filePath,
    required this.initialPage,
    required this.onProgress,
    this.onControllerReady,
  });

  final String filePath;
  final int initialPage;
  final ReaderProgressCallback onProgress;
  final void Function(ReaderPageController)? onControllerReady;

  @override
  State<TxtReaderView> createState() => _TxtReaderViewState();
}

class _TxtReaderViewState extends State<TxtReaderView> {
  static const _charsPerPage = 1400;

  late final PageController _pageController;
  Future<List<String>>? _pagesFuture;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _pagesFuture = _loadPages();
    widget.onControllerReady?.call(
      ReaderPageController(
        nextPage: () => _pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        previousPage: () => _pageController.previousPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
      ),
    );
  }

  Future<List<String>> _loadPages() async {
    final text = await File(widget.filePath).readAsString();
    final pages = <String>[];
    for (var i = 0; i < text.length; i += _charsPerPage) {
      pages.add(text.substring(i, i + _charsPerPage > text.length ? text.length : i + _charsPerPage));
    }
    if (pages.isEmpty) pages.add('');
    if (mounted) {
      widget.onProgress(currentPage: widget.initialPage, totalPages: pages.length);
    }
    return pages;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _pagesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final pages = snapshot.data!;
        return PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          onPageChanged: (page) {
            widget.onProgress(currentPage: page, totalPages: pages.length);
          },
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(
                pages[index],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        );
      },
    );
  }
}
