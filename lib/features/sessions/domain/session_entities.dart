import 'package:freezed_annotation/freezed_annotation.dart';

import '../../files/domain/file_entities.dart';
import '../../videos/domain/video_entities.dart';

part 'session_entities.freezed.dart';

@freezed
abstract class SessionCard with _$SessionCard {
  const factory SessionCard({
    required String id,
    required String title,
    required int videosCount,
    required int filesCount,
    String? description,
  }) = _SessionCard;
}

/// A class session: any number of videos and files (spec §24, §74).
@freezed
abstract class SessionDetails with _$SessionDetails {
  const factory SessionDetails({
    required String id,
    required String title,
    required String topicTitle,
    required List<VideoItem> videos,
    required List<FileItem> files,
    String? description,
  }) = _SessionDetails;
}

abstract interface class SessionsRepository {
  Future<SessionDetails> session(String sessionId);
}
