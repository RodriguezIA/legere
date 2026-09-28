import 'dart:io';

import 'package:flutter/material.dart';

import 'package:legere/data/models/document_format.dart';

/// A document's cover image, or a generated placeholder (icon + title) when
/// no cover was extracted at import time (docs/features/import.md step 4).
class DocumentCover extends StatelessWidget {
  const DocumentCover({
    super.key,
    required this.coverPath,
    required this.title,
    required this.format,
  });

  final String? coverPath;
  final String title;
  final DocumentFormat format;

  @override
  Widget build(BuildContext context) {
    final path = coverPath;
    if (path != null) {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _Placeholder(title: title, format: format),
      );
    }
    return _Placeholder(title: title, format: format);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.title, required this.format});

  final String title;
  final DocumentFormat format;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.secondaryContainer,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_rounded, color: scheme.onSecondaryContainer, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: scheme.onSecondaryContainer,
                ),
          ),
        ],
      ),
    );
  }
}
