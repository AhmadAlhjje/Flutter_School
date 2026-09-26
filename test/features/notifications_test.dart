import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/notifications/domain/notification_entities.dart';
import 'package:student_app/features/notifications/presentation/notifications_page.dart';

class _Notifications implements NotificationsRepository {
  _Notifications({this.unread = 2});

  int unread;
  int markAllCalls = 0;
  bool offline = false;

  @override
  Future<InboxPage> inbox({int page = 1}) async => InboxPage(
    page: 1,
    totalPages: 1,
    items: [
      for (var i = 0; i < 3; i++)
        InboxNotification(
          id: 'n$i',
          kind: NotificationKind.newVideo,
          title: 'فيديو جديد $i',
          body: '',
          createdAt: DateTime(2026, 9, 20 + i),
          readAt: i < unread ? null : DateTime(2026, 9, 25),
        ),
    ],
  );

  @override
  Future<int> unreadCount() async => unread;

  @override
  Future<int> markRead(String id) async => unread;

  @override
  Future<void> markAllRead() async {
    markAllCalls++;
    if (offline) throw const AppFailure(FailureKind.network);
    unread = 0;
  }
}

void main() {
  Future<(InboxPage, ProviderContainer)> openInbox(_Notifications repository) async {
    final container = ProviderContainer(overrides: [notificationsRepositoryProvider.overrideWithValue(repository)]);
    addTearDown(container.dispose);
    container.listen(notificationsControllerProvider, (_, _) {});
    final page = await container.read(notificationsControllerProvider.future);
    await Future<void>.delayed(Duration.zero);
    return (page, container);
  }

  test('opening the notifications marks them all as read — nothing to tap', () async {
    final repository = _Notifications();
    final (page, _) = await openInbox(repository);

    expect(repository.markAllCalls, 1);
    expect(repository.unread, 0);
    // The new ones stay highlighted during this visit, so the student sees which are new.
    expect(page.items.where((item) => item.unread), hasLength(2));
  });

  test('nothing new: no request is sent', () async {
    final repository = _Notifications(unread: 0);
    await openInbox(repository);

    expect(repository.markAllCalls, 0);
  });

  test('without network the inbox still opens; they are marked on the next visit', () async {
    final repository = _Notifications()..offline = true;
    final (page, _) = await openInbox(repository);

    expect(page.items, hasLength(3));
    expect(repository.unread, 2);

    repository.offline = false;
    await openInbox(repository);
    expect(repository.unread, 0);
  });
}
