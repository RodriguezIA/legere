import 'package:flutter/material.dart';

import 'package:legere/core/router/app_router.dart';
import 'package:legere/core/theme/app_theme.dart';

class LegereApp extends StatelessWidget {
  const LegereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'legere',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
