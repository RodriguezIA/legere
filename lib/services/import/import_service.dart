import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/data/models/document_format.dart';
import 'package:legere/data/repositories/document_repository.dart';
import 'package:legere/services/metadata/extracted_metadata.dart';
import 'package:legere/services/metadata/metadata_extractor.dart';

const _uuid = Uuid();

/// Picks files from the system file manager and imports them into the
/// library: copy into app storage, extract metadata/cover, index in the DB.
/// See docs/features/import.md.
class ImportService {
  ImportService(this._repository);

  final DocumentRepository _repository;

  /// Extensions supported today. cbr/mobi are a Phase 6 spike
  /// (docs/PLAN.md §4) and intentionally excluded from the picker.
  static const supportedExtensions = ['epub', 'pdf', 'cbz', 'txt'];

  /// Opens the system file picker (multi-select) and imports every picked
  /// file. Unsupported/corrupt files are skipped rather than aborting the
  /// whole batch. Returns the ids of successfully imported documents.
  Future<List<String>> pickAndImport() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: supportedExtensions,
    );

    final importedIds = <String>[];
    for (final picked in files) {
      final path = picked.path;
      if (path == null) continue;
      final id = await _importSingle(File(path));
      if (id != null) importedIds.add(id);
    }
    return importedIds;
  }

  Future<String?> _importSingle(File source) async {
    final extension = p.extension(source.path).replaceFirst('.', '');
    final format = documentFormatFromExtension(extension);
    if (format == null) return null;

    final id = _uuid.v4();
    final fallbackTitle = p.basenameWithoutExtension(source.path);

    final File copied;
    try {
      copied = await _copyIntoLibrary(source, id, extension);
    } catch (_) {
      return null;
    }

    var metadata = ExtractedMetadata(title: fallbackTitle);
    try {
      metadata = await extractMetadata(copied, format, fallbackTitle);
    } catch (_) {
      // Keep the filename-based fallback; a bad metadata parse shouldn't
      // block the import.
    }

    String? coverPath;
    try {
      coverPath = await _extractAndStoreCover(copied, format, id);
    } catch (_) {
      // No cover — the library card falls back to a generated placeholder.
    }

    final fileSize = await copied.length();

    return _repository.insertDocument(
      DocumentsCompanion.insert(
        id: id,
        title: metadata.title,
        author: Value(metadata.author),
        format: format,
        filePath: copied.path,
        coverPath: Value(coverPath),
        totalPages: Value(metadata.totalPages),
        fileSize: fileSize,
        importedAt: DateTime.now(),
      ),
    );
  }

  Future<File> _copyIntoLibrary(File source, String id, String extension) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final libraryDir = Directory(p.join(docsDir.path, 'library'));
    await libraryDir.create(recursive: true);
    final destPath = p.join(libraryDir.path, '$id.$extension');
    return source.copy(destPath);
  }

  Future<String?> _extractAndStoreCover(
    File file,
    DocumentFormat format,
    String id,
  ) async {
    final bytes = await extractCoverBytes(file, format);
    if (bytes == null) return null;

    final supportDir = await getApplicationSupportDirectory();
    final coversDir = Directory(p.join(supportDir.path, 'covers'));
    await coversDir.create(recursive: true);
    final coverPath = p.join(coversDir.path, '$id.png');
    await File(coverPath).writeAsBytes(bytes);
    return coverPath;
  }
}
