import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_providers.dart';
import '../auth/presentation/auth_controller.dart';
import 'data/offline/offline_downloads_impl.dart';
import 'domain/video_entities.dart';

/// Offline downloads for the signed-in account (null when signed out).
final offlineDownloadsProvider = Provider<OfflineDownloads?>((ref) {
  final account = ref.watch(currentAccountProvider);
  if (account == null) return null;
  return OfflineDownloadsImpl(
    api: ref.watch(apiClientProvider),
    dio: ref.watch(dioProvider),
    secure: ref.watch(secureStoreProvider),
    accountId: account.id,
  );
});
