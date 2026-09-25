import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/router/app_router.dart';
import 'package:student_app/core/router/routes.dart';
import 'package:student_app/features/auth/domain/entities/student_account.dart';
import 'package:student_app/features/auth/presentation/auth_controller.dart';

void main() {
  const account = StudentAccount(id: 'u1', name: 'طالب', phone: '0933333333');

  group('redirectFor', () {
    test('keeps the splash screen while the session is being restored', () {
      expect(redirectFor(const AuthUnknown(), Routes.home), Routes.splash);
      expect(redirectFor(const AuthUnknown(), Routes.splash), isNull);
    });

    test('signed-out users can only reach login and register', () {
      const state = AuthSignedOut();
      expect(redirectFor(state, Routes.home), Routes.login);
      expect(redirectFor(state, Routes.session('s1')), Routes.login);
      expect(redirectFor(state, Routes.player('v1')), Routes.login);
      expect(redirectFor(state, Routes.login), isNull);
      expect(redirectFor(state, Routes.register), isNull);
    });

    test('a device bound to another phone is always sent to the device error screen', () {
      const state = AuthDeviceBlocked();
      expect(redirectFor(state, Routes.home), Routes.deviceError);
      expect(redirectFor(state, Routes.login), Routes.deviceError);
      expect(redirectFor(state, Routes.deviceError), isNull);
    });

    test('a disabled account is always sent to the disabled screen', () {
      const state = AuthAccountDisabled();
      expect(redirectFor(state, Routes.downloads), Routes.accountDisabled);
      expect(redirectFor(state, Routes.accountDisabled), isNull);
    });

    test('signed-in users skip public screens and may open content', () {
      const state = AuthSignedIn(account);
      expect(redirectFor(state, Routes.login), Routes.home);
      expect(redirectFor(state, Routes.splash), Routes.home);
      expect(redirectFor(state, Routes.home), isNull);
      expect(redirectFor(state, Routes.topic('t1')), isNull);
      expect(redirectFor(state, Routes.offlinePlayer('l1')), isNull);
    });
  });
}
