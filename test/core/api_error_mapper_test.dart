import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/network/api_error_mapper.dart';

DioException _response(int status, Object? body) {
  final options = RequestOptions(path: '/student/home');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: options,
    response: Response<Object?>(requestOptions: options, statusCode: status, data: body),
  );
}

Map<String, Object?> _envelope(String code) => {
  'success': false,
  'data': null,
  'message': 'server message',
  'error': {'code': code},
};

void main() {
  group('toFailure', () {
    test('maps backend error codes to failure kinds', () {
      final cases = {
        'ACCESS_DENIED': FailureKind.accessDenied,
        'DEVICE_MISMATCH': FailureKind.deviceMismatch,
        'DEVICE_ALREADY_BOUND': FailureKind.deviceMismatch,
        'ACCOUNT_DISABLED': FailureKind.accountDisabled,
        'INVALID_CREDENTIALS': FailureKind.invalidCredentials,
        'VIDEO_NOT_READY': FailureKind.videoNotReady,
        'RATE_LIMITED': FailureKind.rateLimited,
        'SESSION_REVOKED': FailureKind.sessionExpired,
        'OFFLINE_DISABLED': FailureKind.offlineDisabled,
      };
      cases.forEach((code, kind) {
        final failure = toFailure(_response(403, _envelope(code)));
        expect(failure.kind, kind, reason: code);
        expect(failure.code, code);
        expect(failure.message, 'server message');
      });
    });

    test('keeps unknown codes but classifies them as unknown', () {
      final failure = toFailure(_response(400, _envelope('SOMETHING_NEW')));
      expect(failure.kind, FailureKind.unknown);
      expect(failure.code, 'SOMETHING_NEW');
    });

    test('unmapped codes on 5xx responses are server failures', () {
      final failure = toFailure(_response(503, _envelope('SOMETHING_ELSE')));
      expect(failure.kind, FailureKind.server);
      expect(toFailure(_response(500, _envelope('INTERNAL_ERROR'))).kind, FailureKind.server);
    });

    test('server errors without a code are server failures', () {
      expect(toFailure(_response(502, '<html>Bad gateway</html>')).kind, FailureKind.server);
    });

    test('connection problems are network failures', () {
      final options = RequestOptions(path: '/student/home');
      expect(
        toFailure(DioException.connectionError(requestOptions: options, reason: 'refused')).kind,
        FailureKind.network,
      );
      expect(
        toFailure(DioException.connectionTimeout(requestOptions: options, timeout: Duration.zero)).kind,
        FailureKind.network,
      );
    });

    test('passes AppFailure through, including one wrapped by Dio', () {
      const failure = AppFailure(FailureKind.accessDenied, code: 'X');
      expect(identical(toFailure(failure), failure), isTrue);
      final wrapped = DioException(requestOptions: RequestOptions(), error: failure);
      expect(identical(toFailure(wrapped), failure), isTrue);
    });

    test('anything else is an unknown failure', () {
      expect(toFailure(StateError('boom')).kind, FailureKind.unknown);
    });
  });
}
