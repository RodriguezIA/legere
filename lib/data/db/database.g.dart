// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DocumentFormat, String> format =
      GeneratedColumn<String>(
        'format',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DocumentFormat>($DocumentsTable.$converterformat);
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta(
    'coverPath',
  );
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPagesMeta = const VerificationMeta(
    'totalPages',
  );
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
    'total_pages',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPageMeta = const VerificationMeta(
    'currentPage',
  );
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
    'current_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _readingPositionMeta = const VerificationMeta(
    'readingPosition',
  );
  @override
  late final GeneratedColumn<String> readingPosition = GeneratedColumn<String>(
    'reading_position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    author,
    format,
    filePath,
    coverPath,
    totalPages,
    currentPage,
    readingPosition,
    progress,
    isFavorite,
    fileSize,
    importedAt,
    lastOpenedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('cover_path')) {
      context.handle(
        _coverPathMeta,
        coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta),
      );
    }
    if (data.containsKey('total_pages')) {
      context.handle(
        _totalPagesMeta,
        totalPages.isAcceptableOrUnknown(data['total_pages']!, _totalPagesMeta),
      );
    }
    if (data.containsKey('current_page')) {
      context.handle(
        _currentPageMeta,
        currentPage.isAcceptableOrUnknown(
          data['current_page']!,
          _currentPageMeta,
        ),
      );
    }
    if (data.containsKey('reading_position')) {
      context.handle(
        _readingPositionMeta,
        readingPosition.isAcceptableOrUnknown(
          data['reading_position']!,
          _readingPositionMeta,
        ),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      format: $DocumentsTable.$converterformat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}format'],
        )!,
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      coverPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_path'],
      ),
      totalPages: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pages'],
      ),
      currentPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_page'],
      )!,
      readingPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_position'],
      ),
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened_at'],
      ),
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DocumentFormat, String, String> $converterformat =
      const EnumNameConverter<DocumentFormat>(DocumentFormat.values);
}

class Document extends DataClass implements Insertable<Document> {
  final String id;
  final String title;
  final String? author;
  final DocumentFormat format;
  final String filePath;
  final String? coverPath;
  final int? totalPages;
  final int currentPage;
  final String? readingPosition;
  final double progress;
  final bool isFavorite;
  final int fileSize;
  final DateTime importedAt;
  final DateTime? lastOpenedAt;
  const Document({
    required this.id,
    required this.title,
    this.author,
    required this.format,
    required this.filePath,
    this.coverPath,
    this.totalPages,
    required this.currentPage,
    this.readingPosition,
    required this.progress,
    required this.isFavorite,
    required this.fileSize,
    required this.importedAt,
    this.lastOpenedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    {
      map['format'] = Variable<String>(
        $DocumentsTable.$converterformat.toSql(format),
      );
    }
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || coverPath != null) {
      map['cover_path'] = Variable<String>(coverPath);
    }
    if (!nullToAbsent || totalPages != null) {
      map['total_pages'] = Variable<int>(totalPages);
    }
    map['current_page'] = Variable<int>(currentPage);
    if (!nullToAbsent || readingPosition != null) {
      map['reading_position'] = Variable<String>(readingPosition);
    }
    map['progress'] = Variable<double>(progress);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['file_size'] = Variable<int>(fileSize);
    map['imported_at'] = Variable<DateTime>(importedAt);
    if (!nullToAbsent || lastOpenedAt != null) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    }
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      format: Value(format),
      filePath: Value(filePath),
      coverPath: coverPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPath),
      totalPages: totalPages == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPages),
      currentPage: Value(currentPage),
      readingPosition: readingPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(readingPosition),
      progress: Value(progress),
      isFavorite: Value(isFavorite),
      fileSize: Value(fileSize),
      importedAt: Value(importedAt),
      lastOpenedAt: lastOpenedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOpenedAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      format: $DocumentsTable.$converterformat.fromJson(
        serializer.fromJson<String>(json['format']),
      ),
      filePath: serializer.fromJson<String>(json['filePath']),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      totalPages: serializer.fromJson<int?>(json['totalPages']),
      currentPage: serializer.fromJson<int>(json['currentPage']),
      readingPosition: serializer.fromJson<String?>(json['readingPosition']),
      progress: serializer.fromJson<double>(json['progress']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      lastOpenedAt: serializer.fromJson<DateTime?>(json['lastOpenedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'format': serializer.toJson<String>(
        $DocumentsTable.$converterformat.toJson(format),
      ),
      'filePath': serializer.toJson<String>(filePath),
      'coverPath': serializer.toJson<String?>(coverPath),
      'totalPages': serializer.toJson<int?>(totalPages),
      'currentPage': serializer.toJson<int>(currentPage),
      'readingPosition': serializer.toJson<String?>(readingPosition),
      'progress': serializer.toJson<double>(progress),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'fileSize': serializer.toJson<int>(fileSize),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'lastOpenedAt': serializer.toJson<DateTime?>(lastOpenedAt),
    };
  }

  Document copyWith({
    String? id,
    String? title,
    Value<String?> author = const Value.absent(),
    DocumentFormat? format,
    String? filePath,
    Value<String?> coverPath = const Value.absent(),
    Value<int?> totalPages = const Value.absent(),
    int? currentPage,
    Value<String?> readingPosition = const Value.absent(),
    double? progress,
    bool? isFavorite,
    int? fileSize,
    DateTime? importedAt,
    Value<DateTime?> lastOpenedAt = const Value.absent(),
  }) => Document(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    format: format ?? this.format,
    filePath: filePath ?? this.filePath,
    coverPath: coverPath.present ? coverPath.value : this.coverPath,
    totalPages: totalPages.present ? totalPages.value : this.totalPages,
    currentPage: currentPage ?? this.currentPage,
    readingPosition: readingPosition.present
        ? readingPosition.value
        : this.readingPosition,
    progress: progress ?? this.progress,
    isFavorite: isFavorite ?? this.isFavorite,
    fileSize: fileSize ?? this.fileSize,
    importedAt: importedAt ?? this.importedAt,
    lastOpenedAt: lastOpenedAt.present ? lastOpenedAt.value : this.lastOpenedAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      format: data.format.present ? data.format.value : this.format,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      totalPages: data.totalPages.present
          ? data.totalPages.value
          : this.totalPages,
      currentPage: data.currentPage.present
          ? data.currentPage.value
          : this.currentPage,
      readingPosition: data.readingPosition.present
          ? data.readingPosition.value
          : this.readingPosition,
      progress: data.progress.present ? data.progress.value : this.progress,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('format: $format, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPage: $currentPage, ')
          ..write('readingPosition: $readingPosition, ')
          ..write('progress: $progress, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('fileSize: $fileSize, ')
          ..write('importedAt: $importedAt, ')
          ..write('lastOpenedAt: $lastOpenedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    author,
    format,
    filePath,
    coverPath,
    totalPages,
    currentPage,
    readingPosition,
    progress,
    isFavorite,
    fileSize,
    importedAt,
    lastOpenedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.format == this.format &&
          other.filePath == this.filePath &&
          other.coverPath == this.coverPath &&
          other.totalPages == this.totalPages &&
          other.currentPage == this.currentPage &&
          other.readingPosition == this.readingPosition &&
          other.progress == this.progress &&
          other.isFavorite == this.isFavorite &&
          other.fileSize == this.fileSize &&
          other.importedAt == this.importedAt &&
          other.lastOpenedAt == this.lastOpenedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> author;
  final Value<DocumentFormat> format;
  final Value<String> filePath;
  final Value<String?> coverPath;
  final Value<int?> totalPages;
  final Value<int> currentPage;
  final Value<String?> readingPosition;
  final Value<double> progress;
  final Value<bool> isFavorite;
  final Value<int> fileSize;
  final Value<DateTime> importedAt;
  final Value<DateTime?> lastOpenedAt;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.format = const Value.absent(),
    this.filePath = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.readingPosition = const Value.absent(),
    this.progress = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required String title,
    this.author = const Value.absent(),
    required DocumentFormat format,
    required String filePath,
    this.coverPath = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.readingPosition = const Value.absent(),
    this.progress = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required int fileSize,
    required DateTime importedAt,
    this.lastOpenedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       format = Value(format),
       filePath = Value(filePath),
       fileSize = Value(fileSize),
       importedAt = Value(importedAt);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? format,
    Expression<String>? filePath,
    Expression<String>? coverPath,
    Expression<int>? totalPages,
    Expression<int>? currentPage,
    Expression<String>? readingPosition,
    Expression<double>? progress,
    Expression<bool>? isFavorite,
    Expression<int>? fileSize,
    Expression<DateTime>? importedAt,
    Expression<DateTime>? lastOpenedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (format != null) 'format': format,
      if (filePath != null) 'file_path': filePath,
      if (coverPath != null) 'cover_path': coverPath,
      if (totalPages != null) 'total_pages': totalPages,
      if (currentPage != null) 'current_page': currentPage,
      if (readingPosition != null) 'reading_position': readingPosition,
      if (progress != null) 'progress': progress,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (fileSize != null) 'file_size': fileSize,
      if (importedAt != null) 'imported_at': importedAt,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? author,
    Value<DocumentFormat>? format,
    Value<String>? filePath,
    Value<String?>? coverPath,
    Value<int?>? totalPages,
    Value<int>? currentPage,
    Value<String?>? readingPosition,
    Value<double>? progress,
    Value<bool>? isFavorite,
    Value<int>? fileSize,
    Value<DateTime>? importedAt,
    Value<DateTime?>? lastOpenedAt,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      format: format ?? this.format,
      filePath: filePath ?? this.filePath,
      coverPath: coverPath ?? this.coverPath,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      readingPosition: readingPosition ?? this.readingPosition,
      progress: progress ?? this.progress,
      isFavorite: isFavorite ?? this.isFavorite,
      fileSize: fileSize ?? this.fileSize,
      importedAt: importedAt ?? this.importedAt,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(
        $DocumentsTable.$converterformat.toSql(format.value),
      );
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (readingPosition.present) {
      map['reading_position'] = Variable<String>(readingPosition.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('format: $format, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPage: $currentPage, ')
          ..write('readingPosition: $readingPosition, ')
          ..write('progress: $progress, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('fileSize: $fileSize, ')
          ..write('importedAt: $importedAt, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [documents];
}

typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      required String id,
      required String title,
      Value<String?> author,
      required DocumentFormat format,
      required String filePath,
      Value<String?> coverPath,
      Value<int?> totalPages,
      Value<int> currentPage,
      Value<String?> readingPosition,
      Value<double> progress,
      Value<bool> isFavorite,
      required int fileSize,
      required DateTime importedAt,
      Value<DateTime?> lastOpenedAt,
      Value<int> rowid,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> author,
      Value<DocumentFormat> format,
      Value<String> filePath,
      Value<String?> coverPath,
      Value<int?> totalPages,
      Value<int> currentPage,
      Value<String?> readingPosition,
      Value<double> progress,
      Value<bool> isFavorite,
      Value<int> fileSize,
      Value<DateTime> importedAt,
      Value<DateTime?> lastOpenedAt,
      Value<int> rowid,
    });

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DocumentFormat, DocumentFormat, String>
  get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingPosition => $composableBuilder(
    column: $table.readingPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingPosition => $composableBuilder(
    column: $table.readingPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DocumentFormat, String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingPosition => $composableBuilder(
    column: $table.readingPosition,
    builder: (column) => column,
  );

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
          Document,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<DocumentFormat> format = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> coverPath = const Value.absent(),
                Value<int?> totalPages = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<String?> readingPosition = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                title: title,
                author: author,
                format: format,
                filePath: filePath,
                coverPath: coverPath,
                totalPages: totalPages,
                currentPage: currentPage,
                readingPosition: readingPosition,
                progress: progress,
                isFavorite: isFavorite,
                fileSize: fileSize,
                importedAt: importedAt,
                lastOpenedAt: lastOpenedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> author = const Value.absent(),
                required DocumentFormat format,
                required String filePath,
                Value<String?> coverPath = const Value.absent(),
                Value<int?> totalPages = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<String?> readingPosition = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                required int fileSize,
                required DateTime importedAt,
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                title: title,
                author: author,
                format: format,
                filePath: filePath,
                coverPath: coverPath,
                totalPages: totalPages,
                currentPage: currentPage,
                readingPosition: readingPosition,
                progress: progress,
                isFavorite: isFavorite,
                fileSize: fileSize,
                importedAt: importedAt,
                lastOpenedAt: lastOpenedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, Document>(table),
                  BaseReferences<_$AppDatabase, $DocumentsTable, Document>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
      Document,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
}
