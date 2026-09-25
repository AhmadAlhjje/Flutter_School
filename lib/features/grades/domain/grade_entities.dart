import 'package:freezed_annotation/freezed_annotation.dart';

import '../../subjects/domain/subject_entities.dart';

part 'grade_entities.freezed.dart';

@freezed
abstract class GradeSummary with _$GradeSummary {
  const factory GradeSummary({required String id, required String name, required int subjectsCount}) = _GradeSummary;
}

@freezed
abstract class GradeSubjects with _$GradeSubjects {
  const factory GradeSubjects({
    required String gradeId,
    required String gradeName,
    required List<SubjectCard> subjects,
  }) = _GradeSubjects;
}

abstract interface class GradesRepository {
  Future<List<GradeSummary>> grades();

  Future<GradeSubjects> gradeSubjects(String gradeId);
}
