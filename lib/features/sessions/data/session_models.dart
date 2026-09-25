import '../../files/data/file_models.dart';
import '../../videos/data/video_models.dart';
import '../domain/session_entities.dart';

SessionCard parseSessionCard(Map<String, Object?> json) => SessionCard(
  id: json['id']! as String,
  title: json['title']! as String,
  description: json['description'] as String?,
  videosCount: (json['videosCount'] as num?)?.toInt() ?? 0,
  filesCount: (json['filesCount'] as num?)?.toInt() ?? 0,
);

List<SessionCard> parseSessionCards(Object? data) =>
    (data as List? ?? const []).map((json) => parseSessionCard((json as Map).cast())).toList();

/// `/student/sessions/:id`
SessionDetails parseSessionDetails(Map<String, Object?> json) {
  final session = (json['session']! as Map).cast<String, Object?>();
  return SessionDetails(
    id: session['id']! as String,
    title: session['title']! as String,
    description: session['description'] as String?,
    topicTitle: ((json['topic']! as Map)['title'])! as String,
    videos: parseVideoItems(json['videos']),
    files: parseFiles(json['files']),
  );
}
