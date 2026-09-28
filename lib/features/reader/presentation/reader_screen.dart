import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/data/models/document_format.dart';
import 'package:legere/data/repositories/document_repository.dart';
import 'package:legere/features/library/providers/database_provider.dart';
import 'package:legere/features/reader/presentation/widgets/cbz_reader_view.dart';
import 'package:legere/features/reader/presentation/widgets/epub_reader_view.dart';
import 'package:legere/features/reader/presentation/widgets/pdf_reader_view.dart';
import 'package:legere/features/reader/presentation/widgets/reader_page_controller.dart';
import 'package:legere/features/reader/presentation/widgets/txt_reader_view.dart';
import 'package:legere/features/reader/providers/reader_providers.dart';

/// Full-screen reading experience (docs/features/reader.md). Phase 1 scope:
/// shared header/bottom chrome, per-format content viewer, page navigation,
/// and persisted progress. Immersive tap-to-hide chrome and gestures
/// (swipe/pinch) are Phase 5 polish.
class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key, required this.documentId});

  final String documentId;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  int _currentPage = 0;
  int _totalPages = 0;
  String? _position;
  bool _initialized = false;
  ReaderPageController? _pageController;
  Timer? _saveDebounce;

  // Captured up front: reading `ref` from dispose() is unsafe once the
  // widget is unmounted (Riverpod throws a StateError), so the repository
  // is grabbed once here instead of via ref.read() in _flushProgress.
  late final DocumentRepository _repository = ref.read(documentRepositoryProvider);

  @override
  void dispose() {
    _saveDebounce?.cancel();
    _flushProgress();
    super.dispose();
  }

  void _onProgress({required int currentPage, required int totalPages, String? position}) {
    setState(() {
      _currentPage = currentPage;
      _totalPages = totalPages;
      _position = position;
    });
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 600), _flushProgress);
  }

  void _flushProgress() {
    if (_totalPages <= 0 && _currentPage == 0) return;
    final progress = _totalPages > 0 ? (_currentPage + 1) / _totalPages : 0.0;
    _repository.saveProgress(
      widget.documentId,
      currentPage: _currentPage,
      progress: progress.clamp(0, 1),
      position: _position,
    );
  }

  @override
  Widget build(BuildContext context) {
    final documentAsync = ref.watch(documentByIdProvider(widget.documentId));

    return Scaffold(
      body: documentAsync.when(
        data: (document) {
          if (document == null) {
            return const Center(child: Text('Documento no encontrado.'));
          }
          if (!_initialized) {
            _initialized = true;
            _currentPage = document.currentPage;
            _totalPages = document.totalPages ?? 0;
            _position = document.readingPosition;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _repository.markOpened(widget.documentId);
            });
          }
          return SafeArea(
            child: Column(
              children: [
                _ReaderHeader(
                  title: document.title,
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                ),
                Expanded(child: _buildViewer(document)),
                _ReaderFooter(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  onPrevious: () => _pageController?.previousPage(),
                  onNext: () => _pageController?.nextPage(),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildViewer(Document document) {
    void onControllerReady(ReaderPageController controller) {
      _pageController = controller;
    }

    switch (document.format) {
      case DocumentFormat.pdf:
        return PdfReaderView(
          filePath: document.filePath,
          initialPage: document.currentPage,
          onProgress: _onProgress,
          onControllerReady: onControllerReady,
        );
      case DocumentFormat.cbz:
        return CbzReaderView(
          filePath: document.filePath,
          initialPage: document.currentPage,
          onProgress: _onProgress,
          onControllerReady: onControllerReady,
        );
      case DocumentFormat.epub:
        return EpubReaderView(
          filePath: document.filePath,
          initialPage: document.currentPage,
          onProgress: _onProgress,
          onControllerReady: onControllerReady,
        );
      case DocumentFormat.txt:
        return TxtReaderView(
          filePath: document.filePath,
          initialPage: document.currentPage,
          onProgress: _onProgress,
          onControllerReady: onControllerReady,
        );
      case DocumentFormat.cbr:
      case DocumentFormat.mobi:
        return const Center(
          child: Text('Este formato aún no es compatible (próximamente).'),
        );
    }
  }
}

class _ReaderHeader extends StatelessWidget {
  const _ReaderHeader({
    required this.title,
    required this.currentPage,
    required this.totalPages,
  });

  final String title;
  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              totalPages > 0 ? '${currentPage + 1} / $totalPages' : '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReaderFooter extends StatelessWidget {
  const _ReaderFooter({
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final progress = totalPages > 0 ? (currentPage + 1) / totalPages : 0.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(value: progress.clamp(0, 1), minHeight: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: const Icon(Icons.chevron_left), onPressed: onPrevious),
            Text(totalPages > 0 ? '${currentPage + 1} / $totalPages' : '-'),
            IconButton(icon: const Icon(Icons.chevron_right), onPressed: onNext),
          ],
        ),
      ],
    );
  }
}
