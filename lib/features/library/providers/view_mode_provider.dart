import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:legere/data/models/view_mode.dart';

/// Grid ("mosaico") vs list layout for the library. Grid is the default
/// (docs/features/library.md). Persistence across app restarts is a
/// Phase 3 item (docs/PLAN.md).
class ViewModeNotifier extends Notifier<ViewMode> {
  @override
  ViewMode build() => ViewMode.grid;

  void toggle() {
    state = state == ViewMode.grid ? ViewMode.list : ViewMode.grid;
  }
}

final viewModeProvider = NotifierProvider<ViewModeNotifier, ViewMode>(ViewModeNotifier.new);
