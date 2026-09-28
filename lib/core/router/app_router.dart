import 'package:go_router/go_router.dart';

import 'package:legere/features/library/presentation/library_screen.dart';

/// Route names, used instead of hardcoded path strings when navigating.
abstract final class AppRoutes {
  static const library = 'library';
  static const reader = 'reader';
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.library,
      builder: (context, state) => const LibraryScreen(),
      // Reader route (docs/features/reader.md) is added in Phase 1 as a child
      // route, e.g. '/reader/:documentId', once LibraryScreen can navigate to it.
    ),
  ],
);
