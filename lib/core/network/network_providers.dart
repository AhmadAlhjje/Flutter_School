import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../security/device_identity.dart';
import '../settings/locale_controller.dart';
import '../storage/secure_store.dart';
import '../storage/token_store.dart';
import 'api_client.dart';
import 'auth_interceptor.dart';
import 'offline_cache.dart';
import 'session_events.dart';

/// Composition root for the network stack. Tests override the leaf providers
/// (secure store, dio adapter) instead of mocking whole layers.
final secureStoreProvider = Provider<SecureStore>((ref) => PlatformSecureStore());

final tokenStoreProvider = Provider<TokenStore>((ref) => TokenStore(ref.watch(secureStoreProvider)));

final deviceIdentityProvider = Provider<DeviceIdentity>((ref) => DeviceIdentity(ref.watch(secureStoreProvider)));

final sessionEventsProvider = Provider<SessionEvents>((ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
});

BaseOptions _baseOptions() => BaseOptions(
  baseUrl: AppConfig.apiRoot,
  connectTimeout: AppConfig.connectTimeout,
  receiveTimeout: AppConfig.receiveTimeout,
  contentType: Headers.jsonContentType,
  responseType: ResponseType.json,
);

/// Last answers of the student screens, for opening the app without network.
final responseCacheStoreProvider = Provider<ResponseCacheStore>((ref) => ResponseCacheStore());

final offlineModeProvider = Provider<OfflineMode>((ref) => OfflineMode());

/// Optional transport override (tests).
final httpAdapterProvider = Provider<HttpClientAdapter?>((ref) => null);

final dioProvider = Provider<Dio>((ref) {
  final adapter = ref.watch(httpAdapterProvider);
  final dio = Dio(_baseOptions());
  final refreshDio = Dio(_baseOptions());
  if (adapter != null) {
    dio.httpClientAdapter = adapter;
    refreshDio.httpClientAdapter = adapter;
  }
  dio.interceptors.add(
    AuthInterceptor(
      dio: dio,
      refreshDio: refreshDio,
      tokens: ref.watch(tokenStoreProvider),
      device: ref.watch(deviceIdentityProvider),
      events: ref.watch(sessionEventsProvider),
      language: () => ref.read(localeControllerProvider).languageCode,
    ),
  );
  // After the auth interceptor: a request that still fails (no network, server down) gets the
  // saved copy; a real answer (including "session ended") always wins.
  dio.interceptors.add(
    OfflineCacheInterceptor(ref.watch(responseCacheStoreProvider), mode: ref.watch(offlineModeProvider)),
  );
  ref.onDispose(() {
    dio.close();
    refreshDio.close();
  });
  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(ref.watch(dioProvider)));
