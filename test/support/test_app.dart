import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/l10n/app_localizations.dart';
import 'package:student_app/core/settings/locale_controller.dart';
import 'package:student_app/core/theme/app_theme.dart';
import 'package:student_app/features/auth/domain/entities/student_account.dart';
import 'package:student_app/features/auth/domain/repositories/auth_repository.dart';

/// Arabic MaterialApp around a screen under test.
Widget localizedApp(Widget home, {Locale locale = const Locale('ar')}) => MaterialApp(
  locale: locale,
  theme: AppTheme.light(),
  supportedLocales: supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: home,
);

/// In-memory auth backend with one student account.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.restored});

  static const account = StudentAccount(id: 'student-1', name: 'أحمد علي', phone: '0933333333');

  /// What the next session restore returns (tests change it to simulate the network coming back).
  RestoredSession? restored;
  final List<String> loginPhones = [];

  @override
  Future<PublicConfig> publicConfig() async => const PublicConfig(instituteName: 'معهد النور', selfRegistration: true);

  @override
  Future<StudentAccount> login({required String phone, required String password}) async {
    loginPhones.add(phone);
    if (phone == account.phone && password == 'Student123') return account;
    throw const AppFailure(FailureKind.invalidCredentials, code: 'INVALID_CREDENTIALS');
  }

  /// The last registration received (tests inspect the chosen grade).
  ({String name, String phone, String? gradeId})? registered;

  @override
  Future<List<GradeOption>> gradeOptions() async => const [
    GradeOption(id: 'g-12', name: 'البكالوريا'),
    GradeOption(id: 'g-9', name: 'التاسع'),
  ];

  @override
  Future<StudentAccount> register({
    required String name,
    required String phone,
    required String password,
    String? gradeId,
  }) async {
    registered = (name: name, phone: phone, gradeId: gradeId);
    return StudentAccount(id: 'student-new', name: name, phone: phone);
  }

  @override
  Future<RestoredSession?> restoreSession() async => restored;

  @override
  Future<void> logout() async {}

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {}
}
