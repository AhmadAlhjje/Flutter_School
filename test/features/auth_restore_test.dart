import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/network/api_client.dart';
import 'package:student_app/core/security/device_identity.dart';
import 'package:student_app/core/storage/secure_store.dart';
import 'package:student_app/core/storage/token_store.dart';
import 'package:student_app/features/auth/data/auth_repository_impl.dart';

import '../support/fake_http.dart';

void main() {
  late ResponseBody Function(RequestOptions options) server;
  late AuthRepositoryImpl auth;
  late TokenStore tokens;

  setUp(() async {
    final secure = InMemorySecureStore();
    tokens = TokenStore(secure);
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'))
      ..httpClientAdapter = FakeHttpAdapter((options) => server(options));
    auth = AuthRepositoryImpl(api: ApiClient(dio), tokens: tokens, device: DeviceIdentity(secure), secure: secure);

    // A first, online start saves the account on the phone.
    server = (options) => options.path == '/auth/refresh'
        ? ok({'accessToken': 'access-1', 'refreshToken': 'refresh-1'})
        : ok({'id': 'student-1', 'name': 'أحمد علي', 'phone': '0933333333'});
    await tokens.save(accessToken: 'access-0', refreshToken: 'refresh-0');
    expect((await auth.restoreSession())!.offline, isFalse);
  });

  test('the server down at start: the app opens offline with the saved account, still signed in', () async {
    server = (_) => apiError('SERVICE_UNAVAILABLE', 502);

    final restored = await auth.restoreSession();
    expect(restored!.offline, isTrue);
    expect(restored.account.name, 'أحمد علي');
    expect(await tokens.refreshToken(), 'refresh-1');
  });

  test('no network at start: the same', () async {
    server = (options) => throw DioException.connectionError(requestOptions: options, reason: 'offline');

    expect((await auth.restoreSession())!.offline, isTrue);
    expect(await tokens.refreshToken(), 'refresh-1');
  });

  test('the server says the session is over: signed out', () async {
    server = (_) => apiError('REFRESH_TOKEN_INVALID', 401);

    await expectLater(
      auth.restoreSession(),
      throwsA(isA<AppFailure>().having((failure) => failure.kind, 'kind', FailureKind.sessionExpired)),
    );
    expect(await tokens.refreshToken(), isNull);
  });
}
