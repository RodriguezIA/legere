// Smoke test: the app boots and shows the "Mi Biblioteca" home screen.
//
// Uses an in-memory database override so the test doesn't depend on
// path_provider/native file IO (see AppDatabase.withExecutor). The
// ProviderContainer is managed manually so we can flush drift's stream-close
// timer with an extra pump before the test ends.

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:legere/app.dart';
import 'package:legere/data/db/database.dart';
import 'package:legere/features/library/providers/database_provider.dart';

void main() {
  testWidgets('App boots and shows Mi Biblioteca with its three tabs',
      (WidgetTester tester) async {
    final db = AppDatabase.withExecutor(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const LegereApp()),
    );
    await tester.pump();

    expect(find.text('Mi Biblioteca'), findsOneWidget);
    expect(find.text('Biblioteca'), findsOneWidget);
    expect(find.text('Recientes'), findsOneWidget);
    expect(find.text('Favoritos'), findsOneWidget);

    container.dispose();
    await tester.pump(Duration.zero);
    await db.close();
  });
}
