import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:legere/data/db/database.dart';
import 'package:legere/features/library/providers/database_provider.dart';

/// Loads a single [Document] by id for the reader screen.
final documentByIdProvider =
    FutureProvider.autoDispose.family<Document?, String>((ref, id) {
  return ref.watch(documentRepositoryProvider).getById(id);
});
