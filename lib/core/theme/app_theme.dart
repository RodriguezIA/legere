import 'package:flutter/material.dart';

/// Central Material 3 theme for legere. Keep reader-specific themes
/// (sepia/night) out of here for now — candidate for Phase 7 (docs/PLAN.md §5).
abstract final class AppTheme {
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      );

  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      );
}
