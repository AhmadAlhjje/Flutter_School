import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/notifications/domain/notification_entities.dart';
import 'package:student_app/features/notifications/presentation/notifications_page.dart';

import '../support/test_app.dart';

class _Inbox implements NotificationsRepository {
  int markAllCalls = 0;

  @override
  Future<InboxPage> inbox({int page = 1}) async => InboxPage(
    page: 1,
    totalPages: 1,
    items: [
      InboxNotification(
        id: 'n1',
        kind: NotificationKind.newVideo,
        title: 'فيديو جديد في الرياضيات',
        body: 'تمت إضافة فيديو جديد',
        createdAt: DateTime(2026, 9, 25, 18, 30),
        sessionId: 'sess-1',
      ),
    ],
  );

  @override
  Future<int> unreadCount() async => 1;

  @override
  Future<int> markRead(String id) async => 0;

  @override
  Future<void> markAllRead() async => markAllCalls++;
}

void main() {
  testWidgets('notifications are messages only: read on opening, tapping one opens nothing', (tester) async {
    final inbox = _Inbox();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [notificationsRepositoryProvider.overrideWithValue(inbox)],
        child: localizedApp(const NotificationsPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(inbox.markAllCalls, 1);
    expect(find.byIcon(Icons.done_all_rounded), findsNothing, reason: 'no "mark all as read" button');
    expect(find.descendant(of: find.byType(Card), matching: find.byType(InkWell)), findsNothing);

    // No router here: any navigation would throw.
    await tester.tap(find.text('فيديو جديد في الرياضيات'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('فيديو جديد في الرياضيات'), findsOneWidget);
  });
}
