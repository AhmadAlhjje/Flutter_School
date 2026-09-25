import 'package:freezed_annotation/freezed_annotation.dart';

import '../../files/domain/file_entities.dart';
import '../../topics/domain/topic_entities.dart';

part 'teacher_entities.freezed.dart';

/// A teacher inside a subject (the student's unit of access).
@freezed
abstract class TeacherCard with _$TeacherCard {
  const factory TeacherCard({
    required String subjectTeacherId,
    required String teacherId,
    required String name,
    required int topicsCount,
    required bool locked,
    String? description,
    String? imagePath,
  }) = _TeacherCard;
}

/// The teacher's space in a subject: lessons (topics) and teacher-level files.
@freezed
abstract class TeacherSpace with _$TeacherSpace {
  const factory TeacherSpace({
    required String subjectTeacherId,
    required String subjectName,
    required String teacherName,
    required List<TopicCard> topics,
    required List<FileItem> files,
    String? description,
    String? imagePath,
  }) = _TeacherSpace;
}

abstract interface class TeachersRepository {
  /// Fails with access-denied when the subject or the teacher is locked for the student.
  Future<TeacherSpace> teacherSpace(String subjectTeacherId);
}
