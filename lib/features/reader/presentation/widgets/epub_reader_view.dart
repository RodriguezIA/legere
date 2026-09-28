import 'dart:io';

import 'package:epubx/epubx.dart' as epubx;
import 'package:flutter/material.dart';

import 'package:legere/features/reader/presentation/widgets/reader_page_controller.dart';
import 'package:legere/features/reader/presentation/widgets/reader_progress.dart';

/// EPUB viewer, Phase 1 scope: one "page" per chapter, HTML stripped down to
/// plain text. A proper reflowable/CFI-based renderer is Phase 5 polish
/// (docs/features/reader.md, docs/PLAN.md).
class EpubReaderView extends StatefulWidget {
  const EpubReaderView({
    super.key,
    required this.filePath,
    required this.initialPage,
    required this.onProgress,
    this.onControllerReady,
  });

  final String filePath;

  /// 0-based initial chapter index.
  final int initialPage;
  final ReaderProgressCallback onProgress;
  final void Function(ReaderPageController)? onControllerReady;

  @override
  State<EpubReaderView> createState() => _EpubReaderViewState();
}

class _EpubReaderViewState extends State<EpubReaderView> {
  late final PageController _pageController;
  Future<List<_Chapter>>? _chaptersFuture;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _chaptersFuture = _loadChapters();
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

  Future<List<_Chapter>> _loadChapters() async {
    final bytes = await File(widget.filePath).readAsBytes();
    final book = await epubx.EpubReader.readBook(bytes);
    final flat = <_Chapter>[];

    void flatten(List<epubx.EpubChapter>? chapters) {
      if (chapters == null) return;
      for (final chapter in chapters) {
        flat.add(_Chapter(chapter.Title ?? '', _stripHtml(chapter.HtmlContent ?? '')));
        flatten(chapter.SubChapters);
      }
    }

    flatten(book.Chapters);
    if (flat.isEmpty) {
      flat.add(_Chapter(book.Title ?? '', 'Este documento no tiene capítulos legibles.'));
    }

    if (mounted) {
      widget.onProgress(currentPage: widget.initialPage, totalPages: flat.length);
    }
    return flat;
  }

  static const _namedEntities = {
    'amp': '&', 'lt': '<', 'gt': '>', 'quot': '"', 'apos': "'", 'nbsp': ' ',
  };

  static String _stripHtml(String html) {
    final withoutTags = html
        .replaceAll(RegExp(r'<(script|style)[^>]*>.*?</\1>', dotAll: true), '')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<[^>]+>'), '');

    final decoded = withoutTags.replaceAllMapped(
      RegExp(r'&(#x[0-9A-Fa-f]+|#[0-9]+|[a-zA-Z]+);'),
      (match) {
        final token = match.group(1)!;
        if (token.startsWith('#x')) {
          return String.fromCharCode(int.parse(token.substring(2), radix: 16));
        }
        if (token.startsWith('#')) {
          return String.fromCharCode(int.parse(token.substring(1)));
        }
        return _namedEntities[token] ?? match.group(0)!;
      },
    );

    return decoded.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<_Chapter>>(
      future: _chaptersFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final chapters = snapshot.data!;
        return PageView.builder(
          controller: _pageController,
          itemCount: chapters.length,
          onPageChanged: (page) {
            widget.onProgress(currentPage: page, totalPages: chapters.length);
          },
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (chapter.title.isNotEmpty) ...[
                    Text(chapter.title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                  ],
                  Text(chapter.text, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _Chapter {
  const _Chapter(this.title, this.text);
  final String title;
  final String text;
}
