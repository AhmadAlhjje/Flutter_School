import 'package:freezed_annotation/freezed_annotation.dart';

import '../../files/domain/file_entities.dart';
import '../../teachers/domain/teacher_entities.dart';

part 'subject_entities.freezed.dart';

/// A subject as listed to the student, with its lock state.
@freezed
abstract class SubjectCard with _$SubjectCard {
  const factory SubjectCard({
    required String id,
    required String name,
    required String gradeName,
    required int teachersCount,
    required bool locked,
    String? description,
  }) = _SubjectCard;
}

/// Subject page: visible even when locked; teachers carry their own lock state.
@freezed
abstract class SubjectDetails with _$SubjectDetails {
  const factory SubjectDetails({
    required String id,
    required String name,
    required String gradeName,
    required bool locked,
    required List<TeacherCard> teachers,
    required List<FileItem> files,
    String? description,
  }) = _SubjectDetails;
}

abstract interface class SubjectsRepository {
  Future<SubjectDetails> subject(String subjectId);
}
