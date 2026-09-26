import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/network/auth_interceptor.dart';
import 'package:student_app/core/network/session_events.dart';
import 'package:student_app/core/security/device_identity.dart';
import 'package:student_app/core/storage/secure_store.dart';
import 'package:student_app/core/storage/token_store.dart';

import '../support/fake_http.dart';

class _Harness {
  _Harness(FakeHandler handler) : adapter = FakeHttpAdapter(handler) {
    final options = BaseOptions(baseUrl: 'http://api.test/api/v1');
    dio = Dio(options)..httpClientAdapter = adapter;
    final refreshDio = Dio(options)..httpClientAdapter = adapter;
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        refreshDio: refreshDio,
        tokens: tokens,
        device: DeviceIdentity(secure),
        events: events,
        language: () => 'ar',
      ),
    );
    events.stream.listen(published.add);
  }

  final secure = InMemorySecureStore();
  late final tokens = TokenStore(secure);
  final events = SessionEvents();
  final published = <SessionEndReason>[];
  final FakeHttpAdapter adapter;
  late final Dio dio;

  int get refreshCalls => adapter.requests.where((r) => r.path == '/auth/refresh').length;
}

void main() {
  test('sends the access token, device id and language on every request', () async {
    final harness = _Harness((_) => ok({'ok': true}));
    await harness.tokens.save(accessToken: 'access-1', refreshToken: 'refresh-1');

    await harness.dio.get<Object?>('/student/home');

    final headers = harness.adapter.requests.single.headers;
    expect(headers['Authorization'], 'Bearer access-1');
    expect(headers['Accept-Language'], 'ar');
    expect(headers['X-Device-Id'], isA<String>());
    expect((headers['X-Device-Id'] as String).isNotEmpty, isTrue);
  });

  test('refreshes once for concurrent expired requests and replays them', () async {
    late _Harness harness;
    harness = _Harness((options) async {
      if (options.path == '/auth/refresh') {
        expect((options.data as Map)['refreshToken'], 'refresh-1');
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return ok({'accessToken': 'access-2', 'refreshToken': 'refresh-2'});
      }
      if (options.headers['Authorization'] == 'Bearer access-2') return ok({'path': options.path});
      return apiError('TOKEN_EXPIRED', 401);
    });
    await harness.tokens.save(accessToken: 'access-1', refreshToken: 'refresh-1');

    final responses = await Future.wait([
      harness.dio.get<Map<String, dynamic>>('/student/home'),
      harness.dio.get<Map<String, dynamic>>('/student/grades'),
      harness.dio.get<Map<String, dynamic>>('/student/profile'),
    ]);

    expect(responses.map((r) => (r.data!['data'] as Map)['path']), [
      '/student/home',
      '/student/grades',
      '/student/profile',
    ]);
    expect(harness.refreshCalls, 1);
    expect(harness.tokens.accessToken, 'access-2');
    expect(await harness.tokens.refreshToken(), 'refresh-2');
    expect(harness.published, isEmpty);
  });

  test('a rejected refresh clears the tokens and ends the session', () async {
    final harness = _Harness((options) {
      if (options.path == '/auth/refresh') return apiError('REFRESH_TOKEN_INVALID', 401);
      return apiError('TOKEN_EXPIRED', 401);
    });
    await harness.tokens.save(accessToken: 'access-1', refreshToken: 'stolen-and-reused');

    await expectLater(harness.dio.get<Object?>('/student/home'), throwsA(isA<DioException>()));
    await Future<void>.delayed(Duration.zero);

    expect(harness.tokens.accessToken, isNull);
    expect(await harness.tokens.refreshToken(), isNull);
    expect(harness.published, [SessionEndReason.expired]);
  });

  test('keeps the session when the refresh fails only because the network is down', () async {
    final harness = _Harness((options) {
      if (options.path == '/auth/refresh') {
        throw DioException.connectionError(requestOptions: options, reason: 'offline');
      }
      return apiError('TOKEN_EXPIRED', 401);
    });
    await harness.tokens.save(accessToken: 'access-1', refreshToken: 'refresh-1');

    await expectLater(harness.dio.get<Object?>('/student/home'), throwsA(isA<DioException>()));

    expect(await harness.tokens.refreshToken(), 'refresh-1');
    expect(harness.published, isEmpty);
  });

  test('keeps the session when the server is down or busy during the refresh', () async {
    for (final status in [502, 503, 429]) {
      final harness = _Harness((options) {
        if (options.path == '/auth/refresh') return apiError('SERVICE_UNAVAILABLE', status);
        return apiError('TOKEN_EXPIRED', 401);
      });
      await harness.tokens.save(accessToken: 'access-1', refreshToken: 'refresh-1');

      await expectLater(harness.dio.get<Object?>('/student/home'), throwsA(isA<DioException>()));
      await Future<void>.delayed(Duration.zero);

      expect(await harness.tokens.refreshToken(), 'refresh-1', reason: 'HTTP $status');
      expect(harness.published, isEmpty, reason: 'HTTP $status');
    }
  });

  test('publishes device mismatch and disabled account so the app can leave the session', () async {
    var code = 'DEVICE_MISMATCH';
    final harness = _Harness((_) => apiError(code, 403));
    await harness.tokens.save(accessToken: 'access-1', refreshToken: 'refresh-1');

    await expectLater(harness.dio.get<Object?>('/student/home'), throwsA(isA<DioException>()));
    code = 'ACCOUNT_DISABLED';
    await expectLater(harness.dio.get<Object?>('/student/home'), throwsA(isA<DioException>()));
    await Future<void>.delayed(Duration.zero);

    expect(harness.published, [SessionEndReason.deviceMismatch, SessionEndReason.accountDisabled]);
  });

  test('does not treat a locked item as a session problem', () async {
    final harness = _Harness((_) => apiError('ACCESS_DENIED', 403));
    await harness.tokens.save(accessToken: 'access-1', refreshToken: 'refresh-1');

    await expectLater(harness.dio.get<Object?>('/student/teachers/x'), throwsA(isA<DioException>()));
    await Future<void>.delayed(Duration.zero);

    expect(harness.published, isEmpty);
    expect(harness.refreshCalls, 0);
    expect(harness.tokens.accessToken, 'access-1');
  });
}
