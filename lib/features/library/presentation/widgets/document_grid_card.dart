import 'package:flutter/material.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/features/library/presentation/widgets/document_cover.dart';
import 'package:legere/features/library/presentation/widgets/format_tag.dart';

/// Grid ("mosaico") card for a document — the default library layout.
/// See docs/features/library.md "Grid (mosaico) — default".
class DocumentGridCard extends StatelessWidget {
  const DocumentGridCard({
    super.key,
    required this.document,
    required this.onTap,
    required this.onLongPress,
  });

  final Document document;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = [
      if (document.author != null && document.author!.isNotEmpty) document.author!,
      if (document.totalPages != null) '${document.totalPages} p.',
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded (not a fixed AspectRatio) so the cover yields whatever
          // height the fixed-size text/progress rows below don't need —
          // guarantees no overflow regardless of the grid's tile height.
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DocumentCover(
                    coverPath: document.coverPath,
                    title: document.title,
                    format: document.format,
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: FormatTag(format: document.format),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            document.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: document.progress.clamp(0, 1),
              minHeight: 3,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
