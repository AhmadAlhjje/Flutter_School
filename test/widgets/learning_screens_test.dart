import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/features/auth/auth_providers.dart';
import 'package:student_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/grades/domain/grade_entities.dart';
import 'package:student_app/features/home/domain/home_entities.dart';
import 'package:student_app/features/home/presentation/home_page.dart';
import 'package:student_app/features/subjects/domain/subject_entities.dart';
import 'package:student_app/features/teachers/domain/teacher_entities.dart';
import 'package:student_app/features/teachers/presentation/teacher_page.dart';
import 'package:student_app/shared/widgets/content_tile.dart';
import 'package:student_app/shared/widgets/locked_content.dart';
import 'package:student_app/shared/widgets/state_views.dart';

import '../support/test_app.dart';

class _FakeHome implements HomeRepository {
  @override
  Future<HomeSummary> home() async => const HomeSummary(
    studentName: 'أحمد علي',
    instituteName: 'معهد النور',
    unreadNotifications: 3,
    subjects: [
      SubjectCard(id: 's1', name: 'الرياضيات', gradeName: 'البكالوريا', teachersCount: 2, locked: false),
      SubjectCard(id: 's2', name: 'الفيزياء', gradeName: 'البكالوريا', teachersCount: 1, locked: true),
    ],
    grades: [GradeSummary(id: 'g1', name: 'البكالوريا', subjectsCount: 2)],
  );
}

class _LockedTeachers implements TeachersRepository {
  @override
  Future<TeacherSpace> teacherSpace(String subjectTeacherId) =>
      throw const AppFailure(FailureKind.accessDenied, code: 'ACCESS_DENIED');
}

void main() {
  final signedIn = FakeAuthRepository(restored: const RestoredSession(FakeAuthRepository.account));

  testWidgets('home greets the student and shows open and locked subjects', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(signedIn),
          homeRepositoryProvider.overrideWithValue(_FakeHome()),
        ],
        child: localizedApp(const HomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('معهد النور'), findsOneWidget);
    expect(find.textContaining('مرحباً أحمد'), findsOneWidget);
    expect(find.text('الرياضيات'), findsOneWidget);
    expect(find.text('الفيزياء'), findsOneWidget);
    expect(find.text('مدرسان'), findsOneWidget);
    expect(find.text('مقفل'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('started offline, retry reconnects and loads the online home', (tester) async {
    final auth = FakeAuthRepository(restored: const RestoredSession(FakeAuthRepository.account, offline: true));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          homeRepositoryProvider.overrideWithValue(_FakeHome()),
        ],
        child: localizedApp(const HomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت'), findsOneWidget);
    expect(find.text('الرياضيات'), findsNothing);

    auth.restored = const RestoredSession(FakeAuthRepository.account);
    await tester.tap(find.text('إعادة المحاولة'));
    await tester.pumpAndSettle();

    expect(find.text('الرياضيات'), findsOneWidget);
    expect(find.textContaining('مرحباً أحمد'), findsOneWidget);
  });

  testWidgets('a locked teacher space explains how to get access', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(signedIn),
          teachersRepositoryProvider.overrideWithValue(_LockedTeachers()),
        ],
        child: localizedApp(const TeacherPage(subjectTeacherId: 'st-1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(LockedContentView), findsOneWidget);
    expect(find.text('هذا المحتوى غير متاح لك حالياً. تواصل مع إدارة المعهد لفتحه.'), findsOneWidget);
  });

  testWidgets('locked tiles show a lock and announce it to screen readers', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(localizedApp(const Scaffold(body: ContentTile(title: 'الأستاذ خالد', locked: true))));

    expect(find.byType(LockBadge), findsOneWidget);
    expect(find.bySemanticsLabel('الأستاذ خالد، مقفل'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('errors are shown with a retry action, never a blank screen', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: AsyncValueView<int>(
            value: const AsyncError(AppFailure(FailureKind.network), StackTrace.empty),
            onRetry: () => retried = true,
            data: (_) => const SizedBox(),
          ),
        ),
      ),
    );

    expect(find.text('تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت'), findsOneWidget);
    await tester.tap(find.text('إعادة المحاولة'));
    expect(retried, isTrue);
  });

  testWidgets('English locale renders left-to-right', (tester) async {
    await tester.pumpWidget(localizedApp(const LockedContentPage(), locale: const Locale('en')));
    expect(find.text('Content locked'), findsNWidgets(2));
    expect(find.text('This content is not available to you yet. Contact the institute to unlock it.'), findsOneWidget);
    final direction = Directionality.of(tester.element(find.byType(LockedContentView)));
    expect(direction, TextDirection.ltr);
  });
}
