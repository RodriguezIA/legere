import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:legere/core/router/app_router.dart';
import 'package:legere/data/db/database.dart';
import 'package:legere/data/models/view_mode.dart';
import 'package:legere/features/library/presentation/widgets/document_grid_card.dart';
import 'package:legere/features/library/presentation/widgets/document_list_tile.dart';
import 'package:legere/features/library/presentation/widgets/library_empty_state.dart';
import 'package:legere/features/library/providers/import_provider.dart';
import 'package:legere/features/library/providers/library_providers.dart';
import 'package:legere/features/library/providers/view_mode_provider.dart';

/// "Mi Biblioteca" — the app's home screen (docs/features/library.md).
///
/// Phase 1 scope: header + three tabs with real data, grid/list toggle,
/// document cards, and the "Importar" FAB. Search and the sort bottom sheet
/// land in Phase 3; long-press item actions in Phase 4.
class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final imported = await ref.read(importServiceProvider).pickAndImport();
    if (!context.mounted) return;
    if (imported.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(content: Text('${imported.length} documento(s) importado(s).')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Biblioteca'),
          actions: [
            IconButton(
              tooltip: viewMode == ViewMode.grid ? 'Ver como lista' : 'Ver como mosaico',
              icon: Icon(viewMode == ViewMode.grid ? Icons.view_list : Icons.grid_view),
              onPressed: () => ref.read(viewModeProvider.notifier).toggle(),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Biblioteca'),
              Tab(text: 'Recientes'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _LibraryTab(),
            _RecentTab(),
            _FavoritesTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _import(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('Importar'),
        ),
      ),
    );
  }
}

void _openDocument(BuildContext context, Document document) {
  context.pushNamed(AppRoutes.reader, pathParameters: {'documentId': document.id});
}

class _LibraryTab extends ConsumerWidget {
  const _LibraryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(libraryDocumentsProvider);
    return documents.when(
      data: (items) => items.isEmpty
          ? const LibraryEmptyState(
              icon: Icons.menu_book_outlined,
              message: 'Tu biblioteca está vacía.\nImporta un documento para empezar.',
            )
          : _DocumentCollection(items: items),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _RecentTab extends ConsumerWidget {
  const _RecentTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(recentDocumentsProvider);
    return documents.when(
      data: (items) => items.isEmpty
          ? const LibraryEmptyState(
              icon: Icons.history,
              message: 'Aún no has abierto ningún documento.',
            )
          : _DocumentCollection(items: items),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _FavoritesTab extends ConsumerWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(favoriteDocumentsProvider);
    return documents.when(
      data: (items) => items.isEmpty
          ? const LibraryEmptyState(
              icon: Icons.favorite_border,
              message: 'No tienes documentos favoritos todavía.',
            )
          : _DocumentCollection(items: items),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

/// Renders [items] as a grid (mosaico) or list depending on [viewModeProvider].
class _DocumentCollection extends ConsumerWidget {
  const _DocumentCollection({required this.items});

  final List<Document> items;

  // Long-press item actions land in Phase 4 (docs/features/item-actions.md).
  void _onLongPress(Document document) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);

    if (viewMode == ViewMode.list) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final document = items[index];
          return DocumentListTile(
            document: document,
            onTap: () => _openDocument(context, document),
            onLongPress: () => _onLongPress(document),
          );
        },
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.58,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final document = items[index];
        return DocumentGridCard(
          document: document,
          onTap: () => _openDocument(context, document),
          onLongPress: () => _onLongPress(document),
        );
      },
    );
  }
}
