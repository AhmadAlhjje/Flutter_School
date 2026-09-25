import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_failure.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../catalog_repositories.dart';
import '../videos_providers.dart';

/// What the player needs: an HLS playlist URL, a title and the watermark to overlay.
class PlayerSource {
  const PlayerSource({required this.uri, required this.title, this.watermark});

  final Uri uri;
  final String title;
  final String? watermark;
}

/// Streaming: asks the server for a fresh, device-bound playback grant every time.
final onlineSourceProvider = FutureProvider.autoDispose.family<PlayerSource, String>((ref, videoId) async {
  final grant = await ref.watch(videosRepositoryProvider).requestPlayback(videoId);
  return PlayerSource(uri: grant.manifestUrl, title: grant.title, watermark: grant.watermarkText);
});

/// Offline: serves the encrypted local copy through the private loopback server, which is
/// stopped as soon as the player screen goes away. Offline copies are always watermarked.
final offlineSourceProvider = FutureProvider.autoDispose.family<PlayerSource, String>((ref, licenseId) async {
  final downloads = ref.watch(offlineDownloadsProvider);
  final account = ref.watch(currentAccountProvider);
  if (downloads == null || account == null) throw const AppFailure(FailureKind.sessionExpired);

  final video = (await downloads.list()).where((item) => item.licenseId == licenseId).firstOrNull;
  if (video == null) throw const AppFailure(FailureKind.notFound);
  final uri = await downloads.openStream(licenseId);
  ref.onDispose(() => unawaited(downloads.closeStream()));
  return PlayerSource(uri: uri, title: video.title, watermark: '${account.name} • ${account.phone}');
});
