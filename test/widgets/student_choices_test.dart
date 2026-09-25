import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/features/auth/auth_providers.dart';
import 'package:student_app/features/auth/presentation/pages/register_page.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/files/domain/file_entities.dart';
import 'package:student_app/features/sessions/domain/session_entities.dart';
import 'package:student_app/features/teachers/domain/teacher_entities.dart';
import 'package:student_app/features/teachers/presentation/teacher_page.dart';
import 'package:student_app/features/topics/domain/topic_entities.dart';
import 'package:student_app/features/topics/presentation/topic_page.dart';
import 'package:student_app/features/videos/presentation/video_player_page.dart';

import '../support/test_app.dart';

class _Teachers implements TeachersRepository {
  @override
  Future<TeacherSpace> teacherSpace(String subjectTeacherId) async => const TeacherSpace(
    subjectTeacherId: 'st1',
    subjectName: 'الرياضيات',
    teacherName: 'أحمد',
    topics: [
      TopicCard(id: 't1', title: 'النهايات', sessionsCount: 2),
      TopicCard(id: 't2', title: 'الاشتقاق', sessionsCount: 3),
      TopicCard(id: 't3', title: 'التكامل', sessionsCount: 1),
      TopicCard(id: 't4', title: 'المتتاليات', sessionsCount: 2),
    ],
    files: <FileItem>[],
  );
}

class _Topics implements TopicsRepository {
  @override
  Future<TopicDetails> topic(String topicId) async => const TopicDetails(
    id: 't1',
    title: 'النهايات',
    subjectName: 'الرياضيات',
    teacherName: 'أحمد',
    sessions: [
      SessionCard(id: 's1', title: 'الجلسة الأولى', videosCount: 1, filesCount: 0),
      SessionCard(id: 's2', title: 'الجلسة الثانية', videosCount: 2, filesCount: 1),
    ],
    files: <FileItem>[],
  );
}

void main() {
  Finder field(String label) => find.widgetWithText(TextFormField, label);

  testWidgets('a new student chooses a grade when creating the account', (tester) async {
    final repository = FakeAuthRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: localizedApp(const RegisterPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(field('الاسم الكامل'), 'سارة');
    await tester.enterText(field('رقم الهاتف'), '0955555555');
    await tester.enterText(field('كلمة المرور'), 'Student123');
    await tester.enterText(field('تأكيد كلمة المرور'), 'Student123');
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'تسجيل'));
    await tester.tap(find.widgetWithText(FilledButton, 'تسجيل'));
    await tester.pumpAndSettle();
    expect(repository.registered, isNull, reason: 'the grade is required');
    expect(find.text('اختر صفّك'), findsWidgets);

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('التاسع').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'تسجيل'));
    await tester.pumpAndSettle();
    expect(repository.registered, (name: 'سارة', phone: '0955555555', gradeId: 'g-9'));
  });

  testWidgets('lessons can be searched by name (Arabic letter variants ignored)', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [teachersRepositoryProvider.overrideWithValue(_Teachers())],
        child: localizedApp(const TeacherPage(subjectTeacherId: 'st1')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('الدرس 1'), findsOneWidget);
    expect(find.text('المتتاليات'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'ابحث باسم الدرس'), 'الإشتقاق');
    await tester.pumpAndSettle();
    expect(find.text('الاشتقاق'), findsOneWidget);
    expect(find.text('النهايات'), findsNothing);

    await tester.enterText(find.byType(TextField), 'فيزياء');
    await tester.pumpAndSettle();
    expect(find.text('لا توجد نتائج'), findsOneWidget);
  });

  testWidgets('short lists (a lesson with two sessions) show no search box', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [topicsRepositoryProvider.overrideWithValue(_Topics())],
        child: localizedApp(const TopicPage(topicId: 't1')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('الجلسة الأولى'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('the player offers 0.5x, 1x, 1.5x and 2x', (tester) async {
    double? chosen;
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: SpeedButton(speed: 1, onSelected: (speed) => chosen = speed)),
        ),
      ),
    );
    expect(find.text('1x'), findsOneWidget);
    await tester.tap(find.text('1x'));
    await tester.pumpAndSettle();
    for (final label in ['0.5x', '1.5x', '2x']) {
      expect(find.text(label), findsOneWidget);
    }
    await tester.tap(find.text('1.5x'));
    await tester.pumpAndSettle();
    expect(chosen, 1.5);
    expect([for (final speed in playbackSpeeds) speedLabel(speed)], ['0.5x', '1x', '1.5x', '2x']);
  });
}
