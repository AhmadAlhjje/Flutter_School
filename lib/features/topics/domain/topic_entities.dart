import 'package:freezed_annotation/freezed_annotation.dart';

import '../../files/domain/file_entities.dart';
import '../../sessions/domain/session_entities.dart';

part 'topic_entities.freezed.dart';

/// A lesson / research topic (e.g. التفاضل) in a teacher's space.
@freezed
abstract class TopicCard with _$TopicCard {
  const factory TopicCard({
    required String id,
    required String title,
    required int sessionsCount,
    String? description,
  }) = _TopicCard;
}

@freezed
abstract class TopicDetails with _$TopicDetails {
  const factory TopicDetails({
    required String id,
    required String title,
    required String subjectName,
    required String teacherName,
    required List<SessionCard> sessions,
    required List<FileItem> files,
    String? description,
  }) = _TopicDetails;
}

abstract interface class TopicsRepository {
  Future<TopicDetails> topic(String topicId);
}
