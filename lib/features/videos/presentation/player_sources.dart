import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_failure.dart';
import '../../catalog_repositories.dart';
import '../videos_providers.dart';

/// What the player needs: an HLS playlist URL and a title.
class PlayerSource {
  const PlayerSource({required this.uri, required this.title});

  final Uri uri;
  final String title;
}

/// Streaming: asks the server for a fresh, device-bound playback grant every time.
final onlineSourceProvider = FutureProvider.autoDispose.family<PlayerSource, String>((ref, videoId) async {
  final grant = await ref.watch(videosRepositoryProvider).requestPlayback(videoId);
  return PlayerSource(uri: grant.manifestUrl, title: grant.title);
});

/// Offline: serves the encrypted local copy through the private loopback server, which is
/// stopped as soon as the player screen goes away.
final offlineSourceProvider = FutureProvider.autoDispose.family<PlayerSource, String>((ref, licenseId) async {
  final downloads = ref.watch(offlineDownloadsProvider);
  if (downloads == null) throw const AppFailure(FailureKind.sessionExpired);

  final video = (await downloads.list()).where((item) => item.licenseId == licenseId).firstOrNull;
  if (video == null) throw const AppFailure(FailureKind.notFound);
  final uri = await downloads.openStream(licenseId);
  ref.onDispose(() => unawaited(downloads.closeStream()));
  return PlayerSource(uri: uri, title: video.title);
});
