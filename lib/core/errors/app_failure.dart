/// Failures the domain and presentation layers understand. Pure Dart: no Flutter, Dio or JSON,
/// so the domain layer can depend on it.
enum FailureKind {
  network,
  invalidCredentials,
  sessionExpired,
  deviceMismatch,
  accountDisabled,
  accessDenied,
  notFound,
  videoNotReady,
  validation,
  weakPassword,
  invalidCurrentPassword,
  phoneTaken,
  registrationDisabled,
  rateLimited,
  offlineDisabled,
  server,
  unknown,
}

class AppFailure implements Exception {
  const AppFailure(this.kind, {this.code, this.message});

  final FailureKind kind;

  /// The backend error code (e.g. `ACCESS_DENIED`), when the failure came from the API.
  final String? code;
  final String? message;

  /// Failures that mean the local session is unusable and the user must leave the app flow.
  bool get endsSession =>
      kind == FailureKind.sessionExpired || kind == FailureKind.deviceMismatch || kind == FailureKind.accountDisabled;

  @override
  String toString() => 'AppFailure($kind, code: $code, message: $message)';
}
