// Renders the main student screens with real fonts at phone size, for design review.
// Skipped unless SCREENSHOTS=1:
//   SCREENSHOTS=1 flutter test test/screenshots --update-goldens   (PNGs in build/screenshots)
@TestOn('vm')
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/core/l10n/app_localizations.dart';
import 'package:student_app/core/router/app_router.dart';
import 'package:student_app/core/settings/locale_controller.dart';
import 'package:student_app/core/theme/app_theme.dart';
import 'package:student_app/features/auth/auth_providers.dart';
import 'package:student_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/files/domain/file_entities.dart';
import 'package:student_app/features/home/domain/home_entities.dart';
import 'package:student_app/features/notifications/domain/notification_entities.dart';
import 'package:student_app/features/profile/domain/profile_entities.dart';
import 'package:student_app/features/sessions/domain/session_entities.dart';
import 'package:student_app/features/subjects/domain/subject_entities.dart';
import 'package:student_app/features/teachers/domain/teacher_entities.dart';
import 'package:student_app/features/topics/domain/topic_entities.dart';
import 'package:student_app/features/videos/domain/video_entities.dart';
import 'package:student_app/features/videos/presentation/downloads_controller.dart';

import '../support/test_app.dart';

const _pdf = FileItem(
  id: 'f1',
  title: 'ملخص قوانين التفاضل',
  kind: FileKind.pdf,
  extension: 'pdf',
  mimeType: 'application/pdf',
  sizeBytes: 480000,
);

class _Home implements HomeRepository {
  _Home({this.empty = false});
  final bool empty;
  @override
  Future<HomeSummary> home() async => HomeSummary(
    studentName: 'أحمد علي',
    instituteName: 'معهد النور',
    unreadNotifications: 2,
    subjects: empty
        ? const []
        : const [
            SubjectCard(id: 's1', name: 'الرياضيات', gradeName: 'البكالوريا', teachersCount: 2, locked: false),
            SubjectCard(id: 's2', name: 'الفيزياء', gradeName: 'البكالوريا', teachersCount: 1, locked: false),
            SubjectCard(id: 's3', name: 'الكيمياء', gradeName: 'البكالوريا', teachersCount: 1, locked: true),
            SubjectCard(id: 's4', name: 'اللغة العربية', gradeName: 'البكالوريا', teachersCount: 3, locked: true),
          ],
  );
}

class _Subjects implements SubjectsRepository {
  @override
  Future<SubjectDetails> subject(String subjectId) async => const SubjectDetails(
    id: 's1',
    name: 'الرياضيات',
    gradeName: 'البكالوريا',
    locked: false,
    description: 'التفاضل والتكامل والنهايات لطلاب البكالوريا.',
    teachers: [
      TeacherCard(subjectTeacherId: 'st1', teacherId: 't1', name: 'أحمد', topicsCount: 4, locked: false),
      TeacherCard(subjectTeacherId: 'st2', teacherId: 't2', name: 'محمد', topicsCount: 3, locked: true),
    ],
    files: [_pdf],
  );
}

class _Teachers implements TeachersRepository {
  @override
  Future<TeacherSpace> teacherSpace(String subjectTeacherId) async => const TeacherSpace(
    subjectTeacherId: 'st1',
    subjectName: 'الرياضيات',
    teacherName: 'أحمد',
    description: 'مدرس رياضيات منذ 12 عاماً',
    topics: [
      TopicCard(id: 'tp1', title: 'التفاضل', sessionsCount: 2),
      TopicCard(id: 'tp2', title: 'الاشتقاق', sessionsCount: 3),
      TopicCard(id: 'tp3', title: 'التكامل', sessionsCount: 2),
      TopicCard(id: 'tp4', title: 'النهايات', sessionsCount: 1),
    ],
    files: [_pdf],
  );
}

class _Topics implements TopicsRepository {
  @override
  Future<TopicDetails> topic(String topicId) async => const TopicDetails(
    id: 'tp1',
    title: 'التفاضل',
    subjectName: 'الرياضيات',
    teacherName: 'أحمد',
    sessions: [
      SessionCard(id: 'se1', title: 'الجلسة الأولى', videosCount: 2, filesCount: 1),
      SessionCard(id: 'se2', title: 'الجلسة الثانية', videosCount: 1, filesCount: 0),
    ],
    files: [],
  );
}

class _Sessions implements SessionsRepository {
  @override
  Future<SessionDetails> session(String sessionId) async => const SessionDetails(
    id: 'se1',
    title: 'الجلسة الأولى',
    topicTitle: 'التفاضل',
    videos: [
      VideoItem(id: 'v1', title: 'مقدمة في التفاضل', durationSeconds: 1260),
      VideoItem(id: 'v2', title: 'أمثلة محلولة', durationSeconds: 1815),
      VideoItem(id: 'v3', title: 'تمارين إضافية', durationSeconds: 900),
    ],
    files: [_pdf],
  );
}

class _Notifications implements NotificationsRepository {
  @override
  Future<InboxPage> inbox({int page = 1}) async => InboxPage(
    page: 1,
    totalPages: 1,
    items: [
      InboxNotification(
        id: 'n1',
        kind: NotificationKind.newVideo,
        title: 'فيديو جديد',
        body: 'أضاف الأستاذ أحمد فيديو «أمثلة محلولة» في التفاضل',
        createdAt: DateTime(2026, 9, 25, 10, 30),
      ),
    ],
  );
  @override
  Future<int> unreadCount() async => 2;
  @override
  Future<int> markRead(String id) async => 1;
  @override
  Future<void> markAllRead() async {}
}

class _Profile implements ProfileRepository {
  @override
  Future<StudentProfile> profile() async => const StudentProfile(
    name: 'أحمد علي',
    phone: '0933333333',
    gradeName: 'البكالوريا',
    openSubjectsCount: 2,
    openTeachersCount: 2,
  );
}

class _Downloads extends DownloadsController {
  @override
  Map<String, DownloadStatus> build() => {'v3': const DownloadRunning('تمارين إضافية', 45)};
}

Future<void> _loadFonts() async {
  final cairo = FontLoader('Cairo');
  for (final weight in ['Regular', 'SemiBold', 'Bold']) {
    cairo.addFont(rootBundle.load('assets/fonts/Cairo-$weight.ttf'));
  }
  await cairo.load();
  final flutterRoot = Platform.environment['FLUTTER_ROOT'] ?? '';
  final icons = File('$flutterRoot/bin/cache/artifacts/material_fonts/materialicons-regular.otf');
  final loader = FontLoader('MaterialIcons')..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync())));
  await loader.load();
}

void main() {
  final enabled = Platform.environment['SCREENSHOTS'] == '1';

  group('screens', skip: enabled ? false : 'set SCREENSHOTS=1', () {
    setUpAll(_loadFonts);

    Future<GoRouter> pumpApp(WidgetTester tester, {bool signedIn = true, bool empty = false}) async {
      tester.view.physicalSize = const Size(1080, 2340);
      tester.view.devicePixelRatio = 2.625;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({});
      PackageInfo.setMockInitialValues(
        appName: 'Student',
        packageName: 'app',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: '',
      );
      final prefs = await SharedPreferences.getInstance();
      final auth = FakeAuthRepository(restored: signedIn ? const RestoredSession(FakeAuthRepository.account) : null);
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          authRepositoryProvider.overrideWithValue(auth),
          homeRepositoryProvider.overrideWithValue(_Home(empty: empty)),
          subjectsRepositoryProvider.overrideWithValue(_Subjects()),
          teachersRepositoryProvider.overrideWithValue(_Teachers()),
          topicsRepositoryProvider.overrideWithValue(_Topics()),
          sessionsRepositoryProvider.overrideWithValue(_Sessions()),
          notificationsRepositoryProvider.overrideWithValue(_Notifications()),
          profileRepositoryProvider.overrideWithValue(_Profile()),
          offlineVideosProvider.overrideWith(
            (ref) async => [
              OfflineVideo(
                licenseId: 'lic-1',
                videoId: 'v1',
                title: 'مقدمة في التفاضل',
                expiresAt: DateTime.now().add(const Duration(days: 365)),
                downloadedAt: DateTime.now(),
                sizeBytes: 1,
              ),
            ],
          ),
          downloadsControllerProvider.overrideWith(_Downloads.new),
        ],
      );
      addTearDown(container.dispose);
      final router = container.read(routerProvider);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            locale: const Locale('ar'),
            supportedLocales: supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
      return router;
    }

    Future<void> shot(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('../../build/screenshots/$name.png'));
    }

    testWidgets('login', (tester) async {
      await pumpApp(tester, signedIn: false);
      await shot(tester, '01_login');
    });

    testWidgets('home, subject, teacher, lesson, session', (tester) async {
      final router = await pumpApp(tester);
      await shot(tester, '02_home');
      unawaited(router.push('/subjects/s1'));
      await shot(tester, '03_subject');
      unawaited(router.push('/teachers/st1'));
      await shot(tester, '04_teacher');
      unawaited(router.push('/topics/tp1'));
      await shot(tester, '05_lesson');
      unawaited(router.push('/sessions/se1'));
      await shot(tester, '06_session_videos');
      await tester.tap(find.text('الملفات'));
      await shot(tester, '07_session_files');
    });

    testWidgets('tabs: notifications and account', (tester) async {
      final router = await pumpApp(tester);
      router.go('/notifications');
      await shot(tester, '08_notifications');
      router.go('/profile');
      await shot(tester, '09_account');
    });

    testWidgets('new account', (tester) async {
      await pumpApp(tester, empty: true);
      await shot(tester, '10_new_account');
    });
  });
}
