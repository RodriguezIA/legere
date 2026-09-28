import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:image/image.dart' as img;
import 'package:pdfx/pdfx.dart';

import 'package:legere/data/models/document_format.dart';
import 'package:legere/services/metadata/extracted_metadata.dart';

const _cbzImageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];

/// Extracts title/author/page-count for [file] according to its [format].
/// Falls back to [fallbackTitle] (the original filename) when the format
/// doesn't expose a title. See docs/features/import.md step 3.
Future<ExtractedMetadata> extractMetadata(
  File file,
  DocumentFormat format,
  String fallbackTitle,
) async {
  switch (format) {
    case DocumentFormat.pdf:
      final doc = await PdfDocument.openFile(file.path);
      final pages = doc.pagesCount;
      await doc.close();
      return ExtractedMetadata(title: fallbackTitle, totalPages: pages);

    case DocumentFormat.epub:
      final book = await epubx.EpubReader.readBook(await file.readAsBytes());
      return ExtractedMetadata(
        title: book.Title?.trim().isNotEmpty == true ? book.Title! : fallbackTitle,
        author: book.Author,
      );

    case DocumentFormat.cbz:
      final archive = ZipDecoder().decodeBytes(await file.readAsBytes());
      final pageCount = _cbzImageEntries(archive).length;
      return ExtractedMetadata(title: fallbackTitle, totalPages: pageCount);

    case DocumentFormat.txt:
      // Pagination depends on the reader's viewport; computed on first open.
      return ExtractedMetadata(title: fallbackTitle);

    case DocumentFormat.cbr:
    case DocumentFormat.mobi:
      // Phase 6 spike (docs/PLAN.md §4) — not supported yet.
      return ExtractedMetadata(title: fallbackTitle);
  }
}

/// Extracts a cover image for [file] according to its [format], or `null`
/// when the format has no embeddable cover (the UI falls back to a
/// generated placeholder — see docs/features/import.md step 4).
Future<Uint8List?> extractCoverBytes(File file, DocumentFormat format) async {
  switch (format) {
    case DocumentFormat.pdf:
      final doc = await PdfDocument.openFile(file.path);
      final page = await doc.getPage(1);
      final rendered = await page.render(
        width: page.width,
        height: page.height,
        format: PdfPageImageFormat.png,
      );
      await page.close();
      await doc.close();
      return rendered?.bytes;

    case DocumentFormat.epub:
      final book = await epubx.EpubReader.readBook(await file.readAsBytes());
      final cover = book.CoverImage;
      if (cover == null) return null;
      return Uint8List.fromList(img.encodePng(cover));

    case DocumentFormat.cbz:
      final archive = ZipDecoder().decodeBytes(await file.readAsBytes());
      final images = _cbzImageEntries(archive);
      if (images.isEmpty) return null;
      return images.first.content as Uint8List;

    case DocumentFormat.txt:
    case DocumentFormat.cbr:
    case DocumentFormat.mobi:
      return null;
  }
}

List<ArchiveFile> _cbzImageEntries(Archive archive) {
  final images = archive.files.where((f) {
    if (!f.isFile) return false;
    final ext = f.name.split('.').last.toLowerCase();
    return _cbzImageExtensions.contains(ext);
  }).toList();
  images.sort((a, b) => a.name.compareTo(b.name));
  return images;
}
