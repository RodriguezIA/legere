import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:legere/features/reader/presentation/widgets/reader_page_controller.dart';
import 'package:legere/features/reader/presentation/widgets/reader_progress.dart';

/// CBZ (comic archive) viewer: one zoomable image per page.
/// See docs/features/reader.md "cbz / cbr: image-per-page viewer".
class CbzReaderView extends StatefulWidget {
  const CbzReaderView({
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
  State<CbzReaderView> createState() => _CbzReaderViewState();
}

class _CbzReaderViewState extends State<CbzReaderView> {
  static const _imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];

  late final PageController _pageController;
  Future<List<Uint8List>>? _pagesFuture;

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

  Future<List<Uint8List>> _loadPages() async {
    final bytes = await File(widget.filePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final entries = archive.files.where((f) {
      if (!f.isFile) return false;
      final ext = f.name.split('.').last.toLowerCase();
      return _imageExtensions.contains(ext);
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    final pages = entries.map((e) => e.content as Uint8List).toList();
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
    return FutureBuilder<List<Uint8List>>(
      future: _pagesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final pages = snapshot.data!;
        if (pages.isEmpty) {
          return const Center(child: Text('No se encontraron imágenes.'));
        }
        return PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          onPageChanged: (page) {
            widget.onProgress(currentPage: page, totalPages: pages.length);
          },
          itemBuilder: (context, index) {
            return PhotoView(
              imageProvider: MemoryImage(pages[index]),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
            );
          },
        );
      },
    );
  }
}
