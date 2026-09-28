import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:legere/features/library/providers/library_providers.dart';
import 'package:legere/features/library/presentation/widgets/library_empty_state.dart';

/// "Mi Biblioteca" — the app's home screen (docs/features/library.md).
///
/// Phase 0 scope only: header + the three tabs with empty states. Search,
/// filters, view toggle, cards and the import FAB land in Phases 1 and 3.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Biblioteca'),
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
      ),
    );
  }
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
          : _DocumentPlaceholderList(items: items),
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
          : _DocumentPlaceholderList(items: items),
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
          : _DocumentPlaceholderList(items: items),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

/// Minimal row used until Phase 1 introduces the real grid/list document
/// cards (docs/features/library.md).
class _DocumentPlaceholderList extends StatelessWidget {
  const _DocumentPlaceholderList({required this.items});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final doc = items[index];
        return ListTile(title: Text(doc.title as String));
      },
    );
  }
}
