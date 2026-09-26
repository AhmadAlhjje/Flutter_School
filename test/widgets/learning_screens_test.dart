import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/theme/app_colors.dart';
import 'package:student_app/features/auth/auth_providers.dart';
import 'package:student_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/files/domain/file_entities.dart';
import 'package:student_app/features/files/files_providers.dart';
import 'package:student_app/features/home/domain/home_entities.dart';
import 'package:student_app/features/home/presentation/home_page.dart';
import 'package:student_app/features/sessions/domain/session_entities.dart';
import 'package:student_app/features/sessions/presentation/session_page.dart';
import 'package:student_app/features/subjects/domain/subject_entities.dart';
import 'package:student_app/features/teachers/domain/teacher_entities.dart';
import 'package:student_app/features/teachers/presentation/teacher_page.dart';
import 'package:student_app/features/videos/domain/video_entities.dart';
import 'package:student_app/features/videos/presentation/downloads_controller.dart';
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
  );
}

class _EmptyHome implements HomeRepository {
  @override
  Future<HomeSummary> home() async =>
      const HomeSummary(studentName: 'طالب جديد', instituteName: 'معهد النور', unreadNotifications: 0, subjects: []);
}

class _UnreachableHome implements HomeRepository {
  @override
  Future<HomeSummary> home() => throw const AppFailure(FailureKind.network);
}

class _FakeSessions implements SessionsRepository {
  @override
  Future<SessionDetails> session(String sessionId) async => const SessionDetails(
    id: 'sess-1',
    title: 'الجلسة الأولى',
    topicTitle: 'التفاضل',
    videos: [
      VideoItem(id: 'v1', title: 'مقدمة في التفاضل', durationSeconds: 1200),
      VideoItem(id: 'v2', title: 'تمارين محلولة', durationSeconds: 900),
    ],
    files: [
      FileItem(
        id: 'f1',
        title: 'أوراق العمل',
        kind: FileKind.pdf,
        extension: 'pdf',
        mimeType: 'application/pdf',
        sizeBytes: 2048,
      ),
    ],
  );
}

final _downloaded = OfflineVideo(
  licenseId: 'lic-1',
  videoId: 'v1',
  title: 'مقدمة في التفاضل',
  expiresAt: DateTime.now().add(const Duration(days: 7)),
  downloadedAt: DateTime.now(),
  sizeBytes: 1024,
  subjectName: 'الرياضيات',
  teacherName: 'أحمد',
  topicTitle: 'التفاضل',
  sessionTitle: 'الجلسة الأولى',
);

class _LockedTeachers implements TeachersRepository {
  @override
  Future<TeacherSpace> teacherSpace(String subjectTeacherId) =>
      throw const AppFailure(FailureKind.accessDenied, code: 'ACCESS_DENIED');
}

void main() {
  final signedIn = FakeAuthRepository(restored: const RestoredSession(FakeAuthRepository.account));

  testWidgets('home shows only subjects: open ones under "موادي", locked ones after, no grades', (tester) async {
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
    // Just the greeting — no emoji or icon after the name.
    expect(find.text('مرحباً أحمد'), findsOneWidget);
    expect(find.byIcon(Icons.school_rounded), findsNothing);
    expect(find.text('اختر المادة التي تريد دراستها'), findsOneWidget);
    expect(find.text('موادي'), findsOneWidget);
    expect(find.text('الرياضيات'), findsOneWidget);
    expect(find.text('مدرسان'), findsOneWidget);
    expect(find.text('مواد أخرى'), findsOneWidget);
    expect(find.text('الفيزياء'), findsOneWidget);
    expect(find.text('مقفل — تواصل مع إدارة المعهد لفتحه'), findsOneWidget);
    expect(find.textContaining('البكالوريا'), findsNothing);
    // Open subjects come first.
    expect(tester.getTopLeft(find.text('الرياضيات')).dy, lessThan(tester.getTopLeft(find.text('الفيزياء')).dy));
  });

  testWidgets('a new account with no open subjects is told what happens next', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(signedIn),
          homeRepositoryProvider.overrideWithValue(_EmptyHome()),
        ],
        child: localizedApp(const HomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('حسابك جاهز! لا توجد مواد مفتوحة لك بعد'), findsOneWidget);
    expect(find.text('عندما تفتح إدارة المعهد المواد لحسابك ستظهر هنا مباشرة.'), findsOneWidget);
  });

  testWidgets('offline, home opens exactly as it was (saved copy, no offline message), with the downloads below', (
    tester,
  ) async {
    final auth = FakeAuthRepository(restored: const RestoredSession(FakeAuthRepository.account, offline: true));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          // Offline, the network layer answers with the last saved copy.
          homeRepositoryProvider.overrideWithValue(_FakeHome()),
          offlineVideosProvider.overrideWith((ref) async => [_downloaded]),
        ],
        child: localizedApp(const HomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('غير متصل'), findsNothing);
    expect(find.text('مرحباً أحمد'), findsOneWidget);
    expect(find.text('الرياضيات'), findsOneWidget);
    expect(find.text('الفيزياء'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('التفاضل › الجلسة الأولى'), 300);
    expect(find.text('التحميلات على جهازك'), findsOneWidget);
    expect(find.text('مقدمة في التفاضل'), findsOneWidget);
  });

  testWidgets('offline, the app reconnects by itself when the network returns (nothing to press)', (tester) async {
    final auth = FakeAuthRepository(restored: const RestoredSession(FakeAuthRepository.account, offline: true));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          homeRepositoryProvider.overrideWithValue(_FakeHome()),
          offlineVideosProvider.overrideWith((ref) async => [_downloaded]),
        ],
        child: localizedApp(const HomePage()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('التحميلات على جهازك'), 300);

    await tester.pump(const Duration(seconds: 16));
    await tester.pumpAndSettle();
    expect(find.text('التحميلات على جهازك'), findsOneWidget, reason: 'still offline');

    auth.restored = const RestoredSession(FakeAuthRepository.account);
    await tester.pump(const Duration(seconds: 16));
    await tester.pumpAndSettle();
    expect(find.text('التحميلات على جهازك'), findsNothing, reason: 'online: the normal home');
    expect(find.text('الرياضيات'), findsOneWidget);
  });

  testWidgets('offline with nothing saved yet: the downloads, organized by subject › teacher › lesson › session', (
    tester,
  ) async {
    final auth = FakeAuthRepository(restored: const RestoredSession(FakeAuthRepository.account, offline: true));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          homeRepositoryProvider.overrideWithValue(_UnreachableHome()),
          offlineVideosProvider.overrideWith((ref) async => [_downloaded]),
        ],
        child: localizedApp(const HomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('أنت غير متصل بالإنترنت'), findsOneWidget);
    expect(find.text('الرياضيات · الأستاذ أحمد'), findsOneWidget);
    expect(find.text('مقدمة في التفاضل'), findsOneWidget);
    expect(find.text('التفاضل › الجلسة الأولى'), findsOneWidget);
    expect(find.text('الفيزياء'), findsNothing);
  });

  testWidgets('a session shows its videos and files in two tabs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(signedIn),
          sessionsRepositoryProvider.overrideWithValue(_FakeSessions()),
          offlineVideosProvider.overrideWith((ref) async => [_downloaded]),
          savedFileIdsProvider.overrideWith((ref) async => {'f1'}),
        ],
        child: localizedApp(const SessionPage(sessionId: 'sess-1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الفيديوهات'), findsOneWidget);
    expect(find.text('الملفات'), findsOneWidget);
    expect(find.text('مقدمة في التفاضل'), findsOneWidget);
    expect(find.text('تمارين محلولة'), findsOneWidget);
    // The downloaded video just says "محمّل" (in green), and plays from the device.
    expect(find.text('محمّل'), findsOneWidget);
    expect(find.text('على الجهاز'), findsNothing);
    expect(find.text('أوراق العمل'), findsNothing);

    await tester.tap(find.text('الملفات'));
    await tester.pumpAndSettle();
    expect(find.text('أوراق العمل'), findsOneWidget);
    expect(find.text('مقدمة في التفاضل'), findsNothing);
    // A file opened before is marked the same way: "محمّل", in green.
    final mark = tester.widget<Text>(find.text('محمّل'));
    expect(mark.style?.color, AppColors.success);
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
