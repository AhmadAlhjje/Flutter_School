import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/core/settings/locale_controller.dart';
import 'package:student_app/features/auth/auth_providers.dart';
import 'package:student_app/features/history/watch_history.dart';
import 'package:student_app/features/home/presentation/main_shell.dart';

import '../support/test_app.dart';

void main() {
  Future<ProviderContainer> container() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('remembers where the student stopped, most recent first, and resumes there', () async {
    final c = await container();
    final history = c.read(watchHistoryProvider.notifier);

    history.record(
      videoId: 'v1',
      title: 'مقدمة',
      position: const Duration(seconds: 2),
      duration: const Duration(minutes: 20),
    );
    expect(c.read(watchHistoryProvider), isEmpty, reason: 'a few seconds is not watching');

    history.record(
      videoId: 'v1',
      title: 'مقدمة',
      position: const Duration(minutes: 7),
      duration: const Duration(minutes: 20),
    );
    history.record(
      videoId: 'v2',
      title: 'أمثلة',
      position: const Duration(minutes: 3),
      duration: const Duration(minutes: 30),
    );
    expect(c.read(watchHistoryProvider).map((e) => e.videoId), ['v2', 'v1']);
    expect(history.resumeAt('v1'), const Duration(minutes: 7));
    expect(history.resumeAt('unknown'), Duration.zero);

    // Watched to the end: next time it starts from the beginning.
    history.record(
      videoId: 'v1',
      title: 'مقدمة',
      position: const Duration(minutes: 20),
      duration: const Duration(minutes: 20),
    );
    expect(c.read(watchHistoryProvider).first.finished, isTrue);
    expect(history.resumeAt('v1'), Duration.zero);

    history.remove('v2');
    expect(c.read(watchHistoryProvider).map((e) => e.videoId), ['v1']);
  });

  testWidgets('the bottom bar has five tabs with Home raised in the middle', (tester) async {
    int? tapped;
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: const SizedBox.expand(),
          bottomNavigationBar: MainBottomBar(currentIndex: 2, unreadNotifications: 3, onSelect: (i) => tapped = i),
        ),
      ),
    );
    for (final label in ['مشاهداتي', 'بحث', 'الرئيسية', 'الإشعارات', 'حسابي']) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.text('3'), findsOneWidget, reason: 'unread notifications badge');

    final home = tester.getCenter(find.byIcon(Icons.home_rounded));
    final search = tester.getCenter(find.text('بحث'));
    expect(home.dy, lessThan(search.dy - 20), reason: 'Home stands above the other tabs');
    expect((home.dx - tester.getSize(find.byType(MaterialApp)).width / 2).abs(), lessThan(1));

    await tester.tap(find.text('مشاهداتي'));
    expect(tapped, 0);
    await tester.tapAt(home);
    expect(tapped, 2);
  });
}
