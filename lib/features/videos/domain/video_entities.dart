import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_entities.freezed.dart';

@freezed
abstract class VideoItem with _$VideoItem {
  const factory VideoItem({required String id, required String title, String? description, int? durationSeconds}) =
      _VideoItem;
}

/// Temporary, device-bound permission to stream one video (spec §36, §102).
@freezed
abstract class PlaybackGrant with _$PlaybackGrant {
  const factory PlaybackGrant({
    required String videoId,
    required String title,
    required Uri manifestUrl,
    required DateTime expiresAt,
    int? durationSeconds,
    String? watermarkText,
  }) = _PlaybackGrant;
}

/// A video kept on this device for offline viewing (encrypted segments + keystore-held key).
@freezed
abstract class OfflineVideo with _$OfflineVideo {
  const factory OfflineVideo({
    required String licenseId,
    required String videoId,
    required String title,
    required DateTime expiresAt,
    required DateTime downloadedAt,
    required int sizeBytes,
    int? durationSeconds,
  }) = _OfflineVideo;

  const OfflineVideo._();

  bool get expired => DateTime.now().isAfter(expiresAt);
}

abstract interface class VideosRepository {
  /// Full server-side check (token, device, access, READY) then a signed manifest URL.
  Future<PlaybackGrant> requestPlayback(String videoId);
}

/// Offline viewing (spec §37): encrypted, app-private, device- and account-bound, revocable.
abstract interface class OfflineDownloads {
  Future<List<OfflineVideo>> list();

  /// Downloads the encrypted HLS stream of [videoId]; reports progress 0..1.
  Future<OfflineVideo> download(String videoId, {void Function(double progress)? onProgress});

  Future<void> delete(String licenseId);

  /// Removes local copies whose license the server no longer lists (revoked, expired,
  /// access closed, device reset). Call when online.
  Future<void> sync();

  /// Starts a private loopback stream for a downloaded video and returns its playlist URL.
  Future<Uri> openStream(String licenseId);

  Future<void> closeStream();
}
