import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:legere/features/library/providers/database_provider.dart';
import 'package:legere/services/import/import_service.dart';

final importServiceProvider = Provider<ImportService>((ref) {
  return ImportService(ref.watch(documentRepositoryProvider));
});
