import '../../files/data/file_models.dart';
import '../../sessions/data/session_models.dart';
import '../domain/topic_entities.dart';

TopicCard parseTopicCard(Map<String, Object?> json) => TopicCard(
  id: json['id']! as String,
  title: json['title']! as String,
  description: json['description'] as String?,
  sessionsCount: (json['sessionsCount'] as num?)?.toInt() ?? 0,
);

List<TopicCard> parseTopicCards(Object? data) =>
    (data as List? ?? const []).map((json) => parseTopicCard((json as Map).cast())).toList();

/// `/student/topics/:id`
TopicDetails parseTopicDetails(Map<String, Object?> json) {
  final topic = (json['topic']! as Map).cast<String, Object?>();
  return TopicDetails(
    id: topic['id']! as String,
    title: topic['title']! as String,
    description: topic['description'] as String?,
    subjectName: ((json['subject']! as Map)['name'])! as String,
    teacherName: ((json['teacher']! as Map)['name'])! as String,
    sessions: parseSessionCards(json['sessions']),
    files: parseFiles(json['files']),
  );
}
