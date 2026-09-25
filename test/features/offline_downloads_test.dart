import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/network/api_client.dart';
import 'package:student_app/core/storage/secure_store.dart';
import 'package:student_app/features/videos/data/offline/offline_downloads_impl.dart';

import '../support/fake_http.dart';

const _media = 'http://api.test/api/v1/media/offline/lic-1';
final _key = List<int>.generate(16, (i) => i * 7);
final _segments = {'seg_00000.ts': List<int>.filled(1000, 1), 'seg_00001.ts': List<int>.filled(500, 2)};

const _playlist = '''
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-TARGETDURATION:4
#EXT-X-KEY:METHOD=AES-128,URI="key?token=t1",IV=0x00000000000000000000000000000001
#EXTINF:4.0,
seg_00000.ts?token=t1
#EXTINF:2.0,
seg_00001.ts?token=t1
#EXT-X-ENDLIST
''';

Map<String, Object?> _license({DateTime? expiresAt}) => {
  'licenseId': 'lic-1',
  'videoId': 'video-1',
  'title': 'التفاضل - الجلسة الأولى',
  'expiresAt': (expiresAt ?? DateTime.now().add(const Duration(days: 7))).toUtc().toIso8601String(),
  'durationSeconds': 6,
  'renditions': [
    {'name': '240p', 'height': 240, 'bandwidth': 400000, 'playlistUrl': '$_media/240p/index.m3u8?token=t1'},
    {'name': '360p', 'height': 360, 'bandwidth': 800000, 'playlistUrl': '$_media/360p/index.m3u8?token=t1'},
  ],
};

Future<(int, List<int>)> _get(Uri uri) async {
  final client = HttpClient();
  try {
    final response = await (await client.getUrl(uri)).close();
    final body = await response.fold<List<int>>([], (all, chunk) => all..addAll(chunk));
    return (response.statusCode, body);
  } finally {
    client.close(force: true);
  }
}

void main() {
  late Directory base;
  late InMemorySecureStore secure;
  late List<String> licensesOnServer;
  late bool failSegments;
  late FakeHttpAdapter adapter;
  late OfflineDownloadsImpl downloads;

  setUp(() async {
    base = await Directory.systemTemp.createTemp('offline_test');
    secure = InMemorySecureStore();
    licensesOnServer = ['lic-1'];
    failSegments = false;
    adapter = FakeHttpAdapter((options) {
      final path = options.uri.path;
      if (options.method == 'POST' && path == '/api/v1/student/videos/video-1/offline-license') return ok(_license());
      if (options.method == 'DELETE' && path == '/api/v1/student/offline-licenses/lic-1') {
        licensesOnServer.remove('lic-1');
        return ok(null);
      }
      if (path == '/api/v1/student/offline-licenses') {
        return ok({
          'licenses': [
            for (final id in licensesOnServer) {'licenseId': id},
          ],
        });
      }
      if (path == '/api/v1/media/offline/lic-1/360p/index.m3u8') return textResponse(_playlist);
      if (path == '/api/v1/media/offline/lic-1/360p/key') return bytesResponse(_key);
      final segment = _segments[Uri.parse(path).pathSegments.last];
      if (segment != null && path.startsWith('/api/v1/media/offline/lic-1/360p/')) {
        return failSegments ? apiError('INTERNAL_ERROR', 500) : bytesResponse(segment, contentType: 'video/mp2t');
      }
      return apiError('NOT_FOUND', 404);
    });
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))..httpClientAdapter = adapter;
    downloads = OfflineDownloadsImpl(
      api: ApiClient(dio),
      dio: dio,
      secure: secure,
      accountId: 'student-1',
      baseDirectory: () async => base,
    );
  });

  tearDown(() async {
    await downloads.closeStream();
    await base.delete(recursive: true);
  });

  test('downloads the 360p rendition encrypted, keeps the key only in secure storage', () async {
    final progress = <double>[];
    final video = await downloads.download('video-1', onProgress: progress.add);

    expect(video.licenseId, 'lic-1');
    expect(video.sizeBytes, 1500);
    expect(progress, [0.5, 1.0]);
    expect(adapter.requests.any((r) => r.uri.path.contains('/240p/')), isFalse);

    final dir = Directory('${base.path}/offline/student-1/lic-1');
    final names = dir.listSync().map((e) => e.uri.pathSegments.where((s) => s.isNotEmpty).last).toSet();
    expect(names, {'index.m3u8', 'meta.json', 'seg_00000.ts', 'seg_00001.ts'});
    // Segments are stored exactly as served (still AES-128 encrypted) and the key is not on disk.
    expect(File('${dir.path}/seg_00000.ts').readAsBytesSync(), _segments['seg_00000.ts']);
    for (final file in dir.listSync().whereType<File>()) {
      expect(file.readAsBytesSync(), isNot(_key));
    }
    expect(secure.values['offline.key.lic-1'], base64Encode(_key));
    expect(File('${dir.path}/index.m3u8').readAsStringSync(), isNot(contains('token')));

    final listed = await downloads.list();
    expect(listed.single.title, 'التفاضل - الجلسة الأولى');
  });

  test('plays back through the private loopback server only with the per-playback nonce', () async {
    await downloads.download('video-1');
    final uri = await downloads.openStream('lic-1');
    expect(uri.host, '127.0.0.1');

    final (playlistStatus, playlist) = await _get(uri);
    expect(playlistStatus, 200);
    expect(utf8.decode(playlist), contains('URI="key"'));

    final (keyStatus, key) = await _get(uri.resolve('key'));
    expect(keyStatus, 200);
    expect(key, _key);

    final (segmentStatus, segment) = await _get(uri.resolve('seg_00001.ts'));
    expect(segmentStatus, 200);
    expect(segment, _segments['seg_00001.ts']);

    final wrongNonce = uri.replace(path: '/0123456789abcdef0123456789abcdef/key');
    expect((await _get(wrongNonce)).$1, 404);
    expect((await _get(uri.resolve('meta.json'))).$1, 404);

    await downloads.closeStream();
    await expectLater(_get(uri), throwsA(isA<SocketException>()));
  });

  test('sync removes copies whose license the server no longer lists', () async {
    await downloads.download('video-1');
    licensesOnServer.clear();

    await downloads.sync();

    expect(await downloads.list(), isEmpty);
    expect(secure.values.containsKey('offline.key.lic-1'), isFalse);
    await expectLater(downloads.openStream('lic-1'), throwsA(isA<AppFailure>()));
  });

  test('delete removes the local copy and revokes the license', () async {
    await downloads.download('video-1');

    await downloads.delete('lic-1');

    expect(await downloads.list(), isEmpty);
    expect(licensesOnServer, isEmpty);
  });

  test('a failed download leaves nothing behind and releases the license', () async {
    failSegments = true;

    await expectLater(
      downloads.download('video-1'),
      throwsA(isA<AppFailure>().having((f) => f.kind, 'kind', FailureKind.server)),
    );

    expect(await downloads.list(), isEmpty);
    expect(secure.values, isEmpty);
    expect(licensesOnServer, isEmpty);
  });
}
