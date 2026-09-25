import '../../../core/network/api_client.dart';
import '../domain/notification_entities.dart';

NotificationKind _kind(String value) => switch (value) {
  'NEW_LESSON' => NotificationKind.newLesson,
  'NEW_VIDEO' => NotificationKind.newVideo,
  'NEW_FILE' => NotificationKind.newFile,
  'ACCOUNT' => NotificationKind.account,
  _ => NotificationKind.system,
};

InboxNotification parseInboxNotification(Map<String, Object?> json) {
  final data = json['data'] as Map?;
  final readAt = json['readAt'] as String?;
  return InboxNotification(
    id: json['id']! as String,
    kind: _kind(json['type']! as String),
    title: json['title']! as String,
    body: json['body']! as String,
    createdAt: DateTime.parse(json['createdAt']! as String),
    readAt: readAt == null ? null : DateTime.parse(readAt),
    sessionId: data?['sessionId'] as String?,
    subjectId: data?['subjectId'] as String?,
  );
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<InboxPage> inbox({int page = 1}) => api.get('/student/notifications', (data) {
    final json = asMap(data);
    return InboxPage(
      items: asMapList(json['items']).map(parseInboxNotification).toList(),
      page: (json['page']! as num).toInt(),
      totalPages: (json['totalPages']! as num).toInt(),
    );
  }, query: {'page': page, 'limit': 20});

  @override
  Future<int> unreadCount() =>
      api.get('/student/notifications/unread-count', (data) => (asMap(data)['unread']! as num).toInt());

  @override
  Future<int> markRead(String id) =>
      api.post('/student/notifications/$id/read', (data) => (asMap(data)['unread']! as num).toInt());

  @override
  Future<void> markAllRead() => api.post('/student/notifications/read-all', (_) {});
}
