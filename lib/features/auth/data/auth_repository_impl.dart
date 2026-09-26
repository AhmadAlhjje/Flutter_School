import 'dart:convert';

import '../../../core/errors/app_failure.dart';
import '../../../core/network/api_client.dart';
import '../../../core/security/device_identity.dart';
import '../../../core/storage/secure_store.dart';
import '../../../core/storage/token_store.dart';
import '../domain/entities/student_account.dart';
import '../domain/repositories/auth_repository.dart';
import 'models/auth_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.api, required this.tokens, required this.device, required this.secure});

  static const _accountKey = 'auth.account';

  final ApiClient api;
  final TokenStore tokens;
  final DeviceIdentity device;
  final SecureStore secure;

  @override
  Future<PublicConfig> publicConfig() =>
      api.get('/public/config', (data) => PublicConfigModel.fromJson(asMap(data)).toEntity());

  @override
  Future<StudentAccount> login({required String phone, required String password}) async {
    final descriptor = await device.describe();
    final session = await api.post(
      '/auth/student/login',
      (data) => AppSessionModel.fromJson(asMap(data)),
      body: {'phone': phone, 'password': password, 'device': descriptor.toJson()},
    );
    return _startSession(session);
  }

  @override
  Future<List<GradeOption>> gradeOptions() => api.get(
    '/public/grades',
    (data) => [
      for (final grade in asMapList(data)) GradeOption(id: grade['id']! as String, name: grade['name']! as String),
    ],
  );

  @override
  Future<StudentAccount> register({
    required String name,
    required String phone,
    required String password,
    String? gradeId,
  }) async {
    final descriptor = await device.describe();
    final session = await api.post(
      '/auth/student/register',
      (data) => AppSessionModel.fromJson(asMap(data)),
      body: {'name': name, 'phone': phone, 'password': password, 'gradeId': ?gradeId, 'device': descriptor.toJson()},
    );
    return _startSession(session);
  }

  Future<StudentAccount> _startSession(AppSessionModel session) async {
    await tokens.save(accessToken: session.accessToken, refreshToken: session.refreshToken);
    final account = await _fetchAccount();
    await _cacheAccount(account);
    return account.toEntity();
  }

  Future<AccountModel> _fetchAccount() => api.get('/auth/me', (data) => AccountModel.fromJson(asMap(data)));

  @override
  Future<RestoredSession?> restoreSession() async {
    final refreshToken = await tokens.refreshToken();
    if (refreshToken == null) return null;
    try {
      final session = await api.post(
        '/auth/refresh',
        (data) => AppSessionModel.fromJson(asMap(data)),
        body: {'refreshToken': refreshToken},
      );
      await tokens.save(accessToken: session.accessToken, refreshToken: session.refreshToken);
      final account = await _fetchAccount();
      await _cacheAccount(account);
      return RestoredSession(account.toEntity());
    } on AppFailure catch (failure) {
      if (!_endsSession(failure.kind)) {
        // No network, or the server is down / busy: start offline with the saved account (and the
        // saved screens and downloads) instead of signing the student out.
        final cached = await _cachedAccount();
        return cached == null ? null : RestoredSession(cached.toEntity(), offline: true);
      }
      await tokens.clear();
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await api.post('/auth/logout', (_) {});
    } on AppFailure {
      // The server session may already be gone; local sign-out always completes.
    } finally {
      await tokens.clear();
      await secure.delete(_accountKey);
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) => api.post(
    '/auth/change-password',
    (_) {},
    body: {'currentPassword': currentPassword, 'newPassword': newPassword, 'confirmPassword': confirmPassword},
  );

  /// Only the server's clear "this session is over" signs the student out.
  static bool _endsSession(FailureKind kind) =>
      kind == FailureKind.sessionExpired || kind == FailureKind.deviceMismatch || kind == FailureKind.accountDisabled;

  Future<void> _cacheAccount(AccountModel account) => secure.write(_accountKey, jsonEncode(account.toJson()));

  Future<AccountModel?> _cachedAccount() async {
    final raw = await secure.read(_accountKey);
    if (raw == null) return null;
    return AccountModel.fromJson((jsonDecode(raw) as Map).cast<String, Object?>());
  }
}
