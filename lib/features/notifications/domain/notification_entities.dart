import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entities.freezed.dart';

enum NotificationKind { newLesson, newVideo, newFile, account, system }

@freezed
abstract class InboxNotification with _$InboxNotification {
  const factory InboxNotification({
    required String id,
    required NotificationKind kind,
    required String title,
    required String body,
    required DateTime createdAt,
    DateTime? readAt,
    String? sessionId,
    String? subjectId,
  }) = _InboxNotification;

  const InboxNotification._();

  bool get unread => readAt == null;
}

@freezed
abstract class InboxPage with _$InboxPage {
  const factory InboxPage({required List<InboxNotification> items, required int page, required int totalPages}) =
      _InboxPage;
}

abstract interface class NotificationsRepository {
  Future<InboxPage> inbox({int page = 1});

  Future<int> unreadCount();

  Future<int> markRead(String id);

  Future<void> markAllRead();
}
