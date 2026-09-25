import 'dart:async';

import 'package:dio/dio.dart';

import '../security/device_identity.dart';
import '../storage/token_store.dart';
import 'api_error_mapper.dart';
import 'session_events.dart';

/// Adds credentials to every request and keeps the session alive.
///
/// - `Authorization: Bearer <access token>` and `X-Device-Id` (the bound device) on every call.
/// - On `TOKEN_EXPIRED` the refresh token is rotated once (single-flight across concurrent
///   requests) and the original request is replayed.
/// - Session-ending errors (revoked, device mismatch, disabled) are published on [SessionEvents].
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.refreshDio,
    required this.tokens,
    required this.device,
    required this.events,
    required this.language,
  });

  static const retriedKey = 'auth.retried';

  /// The main client, used to replay a request after refreshing.
  final Dio dio;

  /// A bare client (no interceptors) used for the refresh call itself.
  final Dio refreshDio;
  final TokenStore tokens;
  final DeviceIdentity device;
  final SessionEvents events;
  final String Function() language;

  Future<String?>? _refreshing;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['X-Device-Id'] = await device.identifier();
    options.headers['Accept-Language'] = language();
    final token = tokens.accessToken;
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final code = errorCodeOf(err);
    final options = err.requestOptions;
    final isAuthCall = options.path.startsWith('/auth/');

    if (code == 'TOKEN_EXPIRED' && !isAuthCall && options.extra[retriedKey] != true) {
      final token = await _refresh();
      if (token != null) {
        options.extra[retriedKey] = true;
        try {
          handler.resolve(await dio.fetch<dynamic>(options));
        } on DioException catch (retryError) {
          handler.next(retryError);
        }
        return;
      }
    } else if (!isAuthCall) {
      _publish(code);
    }
    handler.next(err);
  }

  /// Rotates the refresh token once for any number of concurrent callers.
  Future<String?> _refresh() => _refreshing ??= _performRefresh().whenComplete(() => _refreshing = null);

  Future<String?> _performRefresh() async {
    final refreshToken = await tokens.refreshToken();
    if (refreshToken == null) {
      events.emit(SessionEndReason.expired);
      return null;
    }
    try {
      final response = await refreshDio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'X-Device-Id': await device.identifier()}),
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final access = data['accessToken'] as String;
      await tokens.save(accessToken: access, refreshToken: data['refreshToken'] as String);
      return access;
    } on DioException catch (error) {
      final code = errorCodeOf(error);
      if (code == null && error.response == null) return null; // offline: keep the session
      await tokens.clear();
      if (!_publish(code)) events.emit(SessionEndReason.expired);
      return null;
    }
  }

  /// Publishes a session-ending event for [code]; returns whether one was published.
  bool _publish(String? code) {
    switch (code) {
      case 'SESSION_REVOKED':
      case 'REFRESH_TOKEN_INVALID':
        return _emit(SessionEndReason.expired);
      case 'DEVICE_MISMATCH':
      case 'DEVICE_ALREADY_BOUND':
        return _emit(SessionEndReason.deviceMismatch);
      case 'ACCOUNT_DISABLED':
        return _emit(SessionEndReason.accountDisabled);
      default:
        return false;
    }
  }

  bool _emit(SessionEndReason reason) {
    events.emit(reason);
    return true;
  }
}
