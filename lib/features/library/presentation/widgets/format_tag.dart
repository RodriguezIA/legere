import 'package:flutter/material.dart';

import 'package:legere/data/models/document_format.dart';

/// Small tag showing a document's format (e.g. "PDF"), overlaid on its cover
/// (docs/features/library.md).
class FormatTag extends StatelessWidget {
  const FormatTag({super.key, required this.format});

  final DocumentFormat format;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        format.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
