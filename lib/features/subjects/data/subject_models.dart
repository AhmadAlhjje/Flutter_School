import 'package:freezed_annotation/freezed_annotation.dart';

import '../../files/data/file_models.dart';
import '../../teachers/data/teacher_models.dart';
import '../domain/subject_entities.dart';

part 'subject_models.freezed.dart';
part 'subject_models.g.dart';

@freezed
abstract class SubjectCardModel with _$SubjectCardModel {
  const factory SubjectCardModel({
    required String id,
    required String name,
    required String gradeName,
    required int teachersCount,
    required bool locked,
    String? description,
  }) = _SubjectCardModel;

  const SubjectCardModel._();

  factory SubjectCardModel.fromJson(Map<String, Object?> json) => _$SubjectCardModelFromJson(json);

  SubjectCard toEntity() => SubjectCard(
    id: id,
    name: name,
    gradeName: gradeName,
    teachersCount: teachersCount,
    locked: locked,
    description: description,
  );
}

List<SubjectCard> parseSubjectCards(Object? data) =>
    (data as List? ?? const []).map((json) => SubjectCardModel.fromJson((json as Map).cast()).toEntity()).toList();

/// `/student/subjects/:id`
SubjectDetails parseSubjectDetails(Map<String, Object?> json) {
  final subject = (json['subject']! as Map).cast<String, Object?>();
  final grade = (subject['grade']! as Map).cast<String, Object?>();
  return SubjectDetails(
    id: subject['id']! as String,
    name: subject['name']! as String,
    description: subject['description'] as String?,
    gradeName: grade['name']! as String,
    locked: subject['locked']! as bool,
    teachers: parseTeacherCards(json['teachers']),
    files: parseFiles(json['files']),
  );
}
