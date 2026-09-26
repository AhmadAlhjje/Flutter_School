import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/network/api_client.dart';
import 'package:student_app/core/network/auth_interceptor.dart';
import 'package:student_app/core/network/offline_cache.dart';
import 'package:student_app/core/network/session_events.dart';
import 'package:student_app/core/security/device_identity.dart';
import 'package:student_app/core/storage/secure_store.dart';
import 'package:student_app/core/storage/token_store.dart';

import '../support/fake_http.dart';

/// The app's network stack (auth + offline cache, in the app's order) over a scripted server
/// that can be switched off.
class _Harness {
  _Harness(this.dir) {
    final options = BaseOptions(baseUrl: 'http://api.test/api/v1');
    final dio = Dio(options)..httpClientAdapter = adapter;
    final secure = InMemorySecureStore();
    dio.interceptors
      ..add(
        AuthInterceptor(
          dio: dio,
          refreshDio: Dio(options)..httpClientAdapter = adapter,
          tokens: TokenStore(secure),
          device: DeviceIdentity(secure),
          events: SessionEvents(),
          language: () => 'ar',
        ),
      )
      ..add(OfflineCacheInterceptor(store, mode: mode));
    api = ApiClient(dio);
  }

  final Directory dir;
  late final store = ResponseCacheStore(baseDirectory: () async => dir);
  final mode = OfflineMode();
  late final ApiClient api;

  /// null = no network.
  ResponseBody Function(RequestOptions options)? server;
  late final adapter = FakeHttpAdapter((options) {
    final handler = server;
    if (handler == null) throw DioException.connectionError(requestOptions: options, reason: 'no network');
    return handler(options);
  });

  int requestsTo(String path) => adapter.requests.where((r) => r.path == path).length;

  Future<String> home() => api.get('/student/home', (data) => asMap(data)['name']! as String);
}

void main() {
  late Directory dir;
  late _Harness harness;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('offline-cache');
    harness = _Harness(dir);
  });
  tearDown(() => dir.delete(recursive: true));

  test('without network, a screen opens with the last copy the server sent', () async {
    harness.server = (_) => ok({'name': 'الرياضيات'});
    expect(await harness.home(), 'الرياضيات');

    harness.server = null;
    expect(await harness.home(), 'الرياضيات');
  });

  test('online, the server always answers (the saved copy is only a fallback)', () async {
    harness.server = (_) => ok({'name': 'قديم'});
    await harness.home();
    harness.server = (_) => ok({'name': 'جديد'});

    expect(await harness.home(), 'جديد');
    harness.server = null;
    expect(await harness.home(), 'جديد', reason: 'the newest answer replaced the saved one');
  });

  test('a server that is down (5xx) also falls back to the saved copy', () async {
    harness.server = (_) => ok({'name': 'الرياضيات'});
    await harness.home();
    harness.server = (_) => apiError('INTERNAL_ERROR', 502);

    expect(await harness.home(), 'الرياضيات');
  });

  test('a real refusal (locked content) is never hidden by an old copy', () async {
    harness.server = (_) => ok({'name': 'الرياضيات'});
    await harness.home();
    harness.server = (_) => apiError('ACCESS_DENIED', 403);

    await expectLater(
      harness.home(),
      throwsA(isA<AppFailure>().having((failure) => failure.kind, 'kind', FailureKind.accessDenied)),
    );
  });

  test('nothing saved yet: the network error is reported as before', () async {
    await expectLater(
      harness.home(),
      throwsA(isA<AppFailure>().having((failure) => failure.kind, 'kind', FailureKind.network)),
    );
  });

  test('in offline mode the saved copy is used at once, without waiting for the network', () async {
    harness.server = (_) => ok({'name': 'الرياضيات'});
    await harness.home();
    harness.mode.active = true;

    expect(await harness.home(), 'الرياضيات');
    expect(harness.requestsTo('/student/home'), 1, reason: 'the second open never reached the network');
  });

  test('each page and query is saved separately', () async {
    harness.server = (options) => ok({'name': 'page ${options.queryParameters['page']}'});
    Future<String> page(int n) =>
        harness.api.get('/student/notifications', (data) => asMap(data)['name']! as String, query: {'page': n});
    await page(1);
    await page(2);

    harness.server = null;
    expect(await page(1), 'page 1');
    expect(await page(2), 'page 2');
  });

  test('actions, offline licenses and signed media links are never saved', () async {
    harness.server = (_) => ok({'licenses': <Object>[]});
    await harness.api.post('/student/notifications/read-all', (_) {});
    await harness.api.get('/student/offline-licenses', (_) {});
    harness.server = (_) => bytesResponse([1, 2, 3]);
    await harness.api.bytes('http://api.test/media/file.pdf?token=t');

    expect(Directory('${dir.path}/http_cache').existsSync(), isFalse);
    expect(
      OfflineCacheInterceptor.cacheable(RequestOptions(path: '/student/home')),
      isTrue,
      reason: 'screens are saved',
    );
  });

  test('a long search text is saved too', () async {
    final text = 'الرياضيات والفيزياء ' * 20;
    harness.server = (options) => ok({'name': options.queryParameters['q']});
    Future<String> search() =>
        harness.api.get('/student/search', (data) => asMap(data)['name']! as String, query: {'q': text});
    await search();

    harness.server = null;
    expect(await search(), text);
  });

  test('signing out forgets every saved screen', () async {
    harness.server = (_) => ok({'name': 'الرياضيات'});
    await harness.home();
    await harness.store.clear();

    harness.server = null;
    await expectLater(harness.home(), throwsA(isA<AppFailure>()));
  });
}
