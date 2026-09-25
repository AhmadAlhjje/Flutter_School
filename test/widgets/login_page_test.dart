import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/features/auth/auth_providers.dart';
import 'package:student_app/features/auth/presentation/auth_controller.dart';
import 'package:student_app/features/auth/presentation/pages/login_page.dart';

import '../support/test_app.dart';

void main() {
  late FakeAuthRepository repository;

  Future<void> pumpLogin(WidgetTester tester) async {
    repository = FakeAuthRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: localizedApp(const LoginPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder field(String label) => find.widgetWithText(TextFormField, label);

  testWidgets('shows the institute name and validates required fields', (tester) async {
    await pumpLogin(tester);

    expect(find.text('أهلاً بك في معهد النور'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'دخول'));
    await tester.pump();

    expect(find.text('هذا الحقل مطلوب'), findsNWidgets(2));
    expect(repository.loginPhones, isEmpty);
  });

  testWidgets('rejects an invalid phone number before calling the server', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(field('رقم الهاتف'), '12ab');
    await tester.enterText(field('كلمة المرور'), 'whatever1');
    await tester.tap(find.widgetWithText(FilledButton, 'دخول'));
    await tester.pump();

    expect(find.text('رقم الهاتف غير صالح'), findsOneWidget);
    expect(repository.loginPhones, isEmpty);
  });

  testWidgets('shows the server error for wrong credentials', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(field('رقم الهاتف'), '0933333333');
    await tester.enterText(field('كلمة المرور'), 'Wrong1234');
    await tester.tap(find.widgetWithText(FilledButton, 'دخول'));
    await tester.pumpAndSettle();

    expect(find.text('رقم الهاتف أو كلمة المرور غير صحيحة'), findsOneWidget);
  });

  testWidgets('signs in with Arabic-Indic digits normalized', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(field('رقم الهاتف'), '٠٩٣٣ ٣٣٣ ٣٣٣');
    await tester.enterText(field('كلمة المرور'), 'Student123');
    await tester.tap(find.widgetWithText(FilledButton, 'دخول'));
    await tester.pumpAndSettle();

    expect(repository.loginPhones, ['0933333333']);
    final container = ProviderScope.containerOf(tester.element(find.byType(LoginPage)));
    final state = container.read(authControllerProvider);
    expect(state, isA<AuthSignedIn>());
    expect((state as AuthSignedIn).account.name, 'أحمد علي');
  });
}
