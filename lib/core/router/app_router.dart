import 'package:go_router/go_router.dart';

import 'package:legere/features/library/presentation/library_screen.dart';
import 'package:legere/features/reader/presentation/reader_screen.dart';

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
    ),
    GoRoute(
      path: '/reader/:documentId',
      name: AppRoutes.reader,
      builder: (context, state) => ReaderScreen(
        documentId: state.pathParameters['documentId']!,
      ),
    ),
  ],
);
