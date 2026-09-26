import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/presentation/auth_controller.dart';
import 'data/saved_files.dart';

/// The signed-in student's saved files (null while signed out).
final savedFilesProvider = Provider<SavedFiles?>((ref) {
  final accountId = ref.watch(currentAccountProvider.select((account) => account?.id));
  return accountId == null ? null : SavedFiles(accountId: accountId);
});

/// Ids of the files already on this phone (a "على الجهاز" mark in the lists).
final savedFileIdsProvider = FutureProvider.autoDispose<Set<String>>(
  (ref) async => await ref.watch(savedFilesProvider)?.ids() ?? const {},
);
