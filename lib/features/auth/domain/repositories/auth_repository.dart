import '../entities/student_account.dart';

/// Authentication contract used by the presentation layer. Implementations throw `AppFailure`.
abstract interface class AuthRepository {
  Future<PublicConfig> publicConfig();

  /// Signs in and binds this device on the first successful login.
  Future<StudentAccount> login({required String phone, required String password});

  /// Grades to choose from when creating an account.
  Future<List<GradeOption>> gradeOptions();

  Future<StudentAccount> register({
    required String name,
    required String phone,
    required String password,
    String? gradeId,
  });

  /// Restores the previous session from the stored refresh token.
  /// Returns null when there is no session; returns the cached account with
  /// [RestoredSession.offline] when the server cannot be reached.
  Future<RestoredSession?> restoreSession();

  Future<void> logout();

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}

class RestoredSession {
  const RestoredSession(this.account, {this.offline = false});

  final StudentAccount account;
  final bool offline;
}
