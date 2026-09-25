import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error_mapper.dart';
import '../../../../core/network/transfer.dart';
import '../../../../core/storage/secure_store.dart';
import '../../domain/video_entities.dart';
import '../video_models.dart';
import 'hls_playlist.dart';
import 'local_hls_server.dart';

/// Offline copies of videos (spec §37).
///
/// Layout (app-private "Application Support", invisible to file managers):
/// ```text
/// offline/{accountId}/{licenseId}/index.m3u8   playlist rewritten for loopback playback
/// offline/{accountId}/{licenseId}/seg_*.ts     segments exactly as served: AES-128 encrypted
/// offline/{accountId}/{licenseId}/meta.json    title, expiry, size, subject › teacher › lesson › session
/// ```
/// The AES key is kept only in the Keychain/Keystore (`offline.key.{licenseId}`).
/// Bound to the device (license issued to it, key in its keystore), to the account
/// (per-account folder) and revocable (license sync purges what the server no longer lists).
class OfflineDownloadsImpl implements OfflineDownloads {
  OfflineDownloadsImpl({
    required this.api,
    required this.dio,
    required this.secure,
    required this.accountId,
    LocalHlsServer? server,
    Future<Directory> Function()? baseDirectory,
    this.retryDelay = const Duration(seconds: 1),
  }) : _server = server ?? LocalHlsServer(),
       _baseDirectory = baseDirectory ?? getApplicationSupportDirectory;

  /// Segments downloaded at the same time (several connections are much faster on long routes).
  static const segmentConnections = 5;

  final ApiClient api;
  final Dio dio;
  final SecureStore secure;
  final String accountId;
  final LocalHlsServer _server;
  final Future<Directory> Function() _baseDirectory;
  final Duration retryDelay;

  static String _keyName(String licenseId) => 'offline.key.$licenseId';

  Future<Directory> _accountDir() async {
    final base = await _baseDirectory();
    final dir = Directory('${base.path}/offline/$accountId');
    await dir.create(recursive: true);
    return dir;
  }

  Future<Directory> _licenseDir(String licenseId) async => Directory('${(await _accountDir()).path}/$licenseId');

  @override
  Future<List<OfflineVideo>> list() async {
    final dir = await _accountDir();
    final videos = <OfflineVideo>[];
    await for (final entity in dir.list()) {
      if (entity is! Directory) continue;
      final meta = File('${entity.path}/meta.json');
      if (!await meta.exists()) continue;
      try {
        videos.add(_fromMeta(jsonDecode(await meta.readAsString()) as Map<String, dynamic>));
      } on FormatException {
        await entity.delete(recursive: true);
      }
    }
    videos.sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));
    return videos;
  }

  @override
  Future<OfflineVideo> download(String videoId, {void Function(TransferProgress progress)? onProgress}) async {
    final license = await api.post(
      '/student/videos/$videoId/offline-license',
      (data) => OfflineLicenseModel.fromJson(asMap(data)),
    );
    final rendition = _pickRendition(license.renditions);
    final dir = await _licenseDir(license.licenseId);
    await dir.create(recursive: true);

    try {
      final playlistText = await api.text(rendition.playlistUrl.toString());
      final parsed = parseMediaPlaylist(playlistText);
      if (parsed.keyUri == null || parsed.segmentUris.isEmpty) {
        throw const AppFailure(FailureKind.videoNotReady);
      }
      final key = await api.bytes(rendition.playlistUrl.resolve(parsed.keyUri!).toString());
      if (key.length != 16) throw const AppFailure(FailureKind.server, code: 'BAD_KEY');

      // Several segments at once, each retried on network hiccups. Progress counts every segment
      // equally and, inside a segment, by bytes — so it moves smoothly instead of in big steps.
      final count = parsed.segmentUris.length;
      final received = List<int>.filled(count, 0);
      final expected = List<int>.filled(count, 0);
      final finished = List<bool>.filled(count, false);
      void report() {
        var fraction = 0.0;
        for (var i = 0; i < count; i++) {
          fraction += finished[i] ? 1 : (expected[i] > 0 ? received[i] / expected[i] : 0);
        }
        onProgress?.call(TransferProgress(fraction / count, received.fold(0, (sum, bytes) => sum + bytes)));
      }

      try {
        await runPool(List<int>.generate(count, (i) => i), segmentConnections, (i) async {
          final uri = rendition.playlistUrl.resolve(parsed.segmentUris[i]);
          final target = File('${dir.path}/${segmentFileName(parsed.segmentUris[i])}');
          await withRetry(
            () => dio.download(
              uri.toString(),
              target.path,
              onReceiveProgress: (bytes, total) {
                received[i] = bytes;
                expected[i] = total;
                report();
              },
            ),
            delay: retryDelay,
          );
          received[i] = await target.length();
          finished[i] = true;
          report();
        });
      } on DioException catch (error) {
        throw toFailure(error);
      }
      final size = received.fold(0, (sum, bytes) => sum + bytes);

      await File('${dir.path}/index.m3u8').writeAsString(buildLocalPlaylist(playlistText));
      await secure.write(_keyName(license.licenseId), base64Encode(key));
      final video = OfflineVideo(
        licenseId: license.licenseId,
        videoId: license.videoId,
        title: license.title,
        expiresAt: license.expiresAt,
        downloadedAt: DateTime.now(),
        sizeBytes: size,
        durationSeconds: license.durationSeconds,
        subjectName: license.path['subject'],
        teacherName: license.path['teacher'],
        topicTitle: license.path['topic'],
        sessionTitle: license.path['session'],
      );
      await File('${dir.path}/meta.json').writeAsString(jsonEncode(_toMeta(video)));
      return video;
    } catch (error) {
      await _removeLocal(license.licenseId);
      await _revokeRemote(license.licenseId);
      rethrow;
    }
  }

  /// A mid-quality rendition keeps downloads reasonably small (~360–480p when available).
  RenditionModel _pickRendition(List<RenditionModel> renditions) {
    if (renditions.isEmpty) throw const AppFailure(FailureKind.videoNotReady);
    final sorted = [...renditions]..sort((a, b) => a.height.compareTo(b.height));
    return sorted.firstWhere((r) => r.height >= 360, orElse: () => sorted.last);
  }

  @override
  Future<void> delete(String licenseId) async {
    await _removeLocal(licenseId);
    await _revokeRemote(licenseId);
  }

  @override
  Future<void> sync() async {
    final valid = await api.get(
      '/student/offline-licenses',
      (data) => asMapList(asMap(data)['licenses']).map((item) => item['licenseId']! as String).toSet(),
    );
    for (final video in await list()) {
      if (!valid.contains(video.licenseId) || video.expired) await _removeLocal(video.licenseId);
    }
  }

  @override
  Future<Uri> openStream(String licenseId) async {
    final dir = await _licenseDir(licenseId);
    final meta = File('${dir.path}/meta.json');
    if (!await meta.exists()) throw const AppFailure(FailureKind.notFound);
    final video = _fromMeta(jsonDecode(await meta.readAsString()) as Map<String, dynamic>);
    if (video.expired) throw const AppFailure(FailureKind.accessDenied, code: 'OFFLINE_EXPIRED');
    final encodedKey = await secure.read(_keyName(licenseId));
    if (encodedKey == null) throw const AppFailure(FailureKind.accessDenied, code: 'OFFLINE_KEY_MISSING');
    return _server.start(directory: dir, key: Uint8List.fromList(base64Decode(encodedKey)));
  }

  @override
  Future<void> closeStream() => _server.stop();

  Future<void> _removeLocal(String licenseId) async {
    final dir = await _licenseDir(licenseId);
    if (await dir.exists()) await dir.delete(recursive: true);
    await secure.delete(_keyName(licenseId));
  }

  Future<void> _revokeRemote(String licenseId) async {
    try {
      await api.delete('/student/offline-licenses/$licenseId', (_) {});
    } on AppFailure {
      // Best effort: the license also expires server-side and is purged on the next sync.
    }
  }

  Map<String, Object?> _toMeta(OfflineVideo video) => {
    'licenseId': video.licenseId,
    'videoId': video.videoId,
    'title': video.title,
    'expiresAt': video.expiresAt.toIso8601String(),
    'downloadedAt': video.downloadedAt.toIso8601String(),
    'sizeBytes': video.sizeBytes,
    'durationSeconds': video.durationSeconds,
    'subjectName': video.subjectName,
    'teacherName': video.teacherName,
    'topicTitle': video.topicTitle,
    'sessionTitle': video.sessionTitle,
  };

  OfflineVideo _fromMeta(Map<String, dynamic> json) => OfflineVideo(
    licenseId: json['licenseId'] as String,
    videoId: json['videoId'] as String,
    title: json['title'] as String,
    expiresAt: DateTime.parse(json['expiresAt'] as String),
    downloadedAt: DateTime.parse(json['downloadedAt'] as String),
    sizeBytes: (json['sizeBytes'] as num).toInt(),
    durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    subjectName: json['subjectName'] as String?,
    teacherName: json['teacherName'] as String?,
    topicTitle: json['topicTitle'] as String?,
    sessionTitle: json['sessionTitle'] as String?,
  );
}
