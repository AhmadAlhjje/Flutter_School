import 'package:dio/dio.dart';

import '../errors/app_failure.dart';

/// Maps backend error codes (backend project: src/core/errors/error-codes.ts) to failures.
const Map<String, FailureKind> _codeToKind = {
  'INVALID_CREDENTIALS': FailureKind.invalidCredentials,
  'UNAUTHENTICATED': FailureKind.sessionExpired,
  'TOKEN_EXPIRED': FailureKind.sessionExpired,
  'TOKEN_INVALID': FailureKind.sessionExpired,
  'SESSION_REVOKED': FailureKind.sessionExpired,
  'REFRESH_TOKEN_INVALID': FailureKind.sessionExpired,
  'ACCOUNT_DISABLED': FailureKind.accountDisabled,
  'DEVICE_ALREADY_BOUND': FailureKind.deviceMismatch,
  'DEVICE_MISMATCH': FailureKind.deviceMismatch,
  'ACCESS_DENIED': FailureKind.accessDenied,
  'FORBIDDEN': FailureKind.accessDenied,
  'NOT_FOUND': FailureKind.notFound,
  'ROUTE_NOT_FOUND': FailureKind.notFound,
  'ITEM_ARCHIVED': FailureKind.notFound,
  'PARENT_ARCHIVED': FailureKind.notFound,
  'FILE_NOT_FOUND': FailureKind.notFound,
  'VIDEO_NOT_FOUND': FailureKind.notFound,
  'VIDEO_NOT_READY': FailureKind.videoNotReady,
  'CONTENT_NOT_READY': FailureKind.videoNotReady,
  'VALIDATION_ERROR': FailureKind.validation,
  'WEAK_PASSWORD': FailureKind.weakPassword,
  'INVALID_CURRENT_PASSWORD': FailureKind.invalidCurrentPassword,
  'PASSWORD_CONFIRMATION_MISMATCH': FailureKind.validation,
  'PHONE_ALREADY_EXISTS': FailureKind.phoneTaken,
  'REGISTRATION_DISABLED': FailureKind.registrationDisabled,
  'RATE_LIMITED': FailureKind.rateLimited,
  'OFFLINE_DISABLED': FailureKind.offlineDisabled,
  'MEDIA_TOKEN_INVALID': FailureKind.accessDenied,
  'SERVICE_UNAVAILABLE': FailureKind.server,
  'INTERNAL_ERROR': FailureKind.server,
};

/// The backend error code carried by a Dio failure, if any.
String? errorCodeOf(DioException error) {
  final data = error.response?.data;
  if (data is Map<String, dynamic>) {
    final inner = data['error'];
    if (inner is Map<String, dynamic> && inner['code'] is String) return inner['code'] as String;
  }
  return null;
}

AppFailure mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const AppFailure(FailureKind.network);
    case DioExceptionType.badCertificate:
      return const AppFailure(FailureKind.network, code: 'BAD_CERTIFICATE');
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
    case DioExceptionType.badResponse:
    case DioExceptionType.transformTimeout:
      break;
  }
  final code = errorCodeOf(error);
  final data = error.response?.data;
  final message = data is Map<String, dynamic> && data['message'] is String ? data['message'] as String : null;
  final status = error.response?.statusCode;
  if (code != null) {
    final fallback = status != null && status >= 500 ? FailureKind.server : FailureKind.unknown;
    return AppFailure(_codeToKind[code] ?? fallback, code: code, message: message);
  }
  if (status == null) return const AppFailure(FailureKind.network);
  if (status >= 500) return AppFailure(FailureKind.server, message: message);
  return AppFailure(FailureKind.unknown, message: message);
}

/// Converts any thrown object into an [AppFailure].
AppFailure toFailure(Object error) {
  if (error is AppFailure) return error;
  if (error is DioException) {
    final inner = error.error;
    if (inner is AppFailure) return inner;
    return mapDioException(error);
  }
  return AppFailure(FailureKind.unknown, message: error.toString());
}
