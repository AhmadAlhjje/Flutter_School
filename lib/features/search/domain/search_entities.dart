import 'package:freezed_annotation/freezed_annotation.dart';

import '../../subjects/domain/subject_entities.dart';
import '../../teachers/domain/teacher_entities.dart';

part 'search_entities.freezed.dart';

/// A lesson-level hit (topic, session or video) the student can open.
@freezed
abstract class SearchHit with _$SearchHit {
  const factory SearchHit({required String id, required String title, String? context, int? durationSeconds}) =
      _SearchHit;
}

@freezed
abstract class SearchResults with _$SearchResults {
  const factory SearchResults({
    required List<SubjectCard> subjects,
    required List<TeacherCard> teachers,
    required List<SearchHit> topics,
    required List<SearchHit> sessions,
    required List<SearchHit> videos,
  }) = _SearchResults;

  const SearchResults._();

  bool get isEmpty => subjects.isEmpty && teachers.isEmpty && topics.isEmpty && sessions.isEmpty && videos.isEmpty;
}

abstract interface class SearchRepository {
  Future<SearchResults> search(String query);
}
