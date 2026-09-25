import '../../files/data/file_models.dart';
import '../../topics/data/topic_models.dart';
import '../domain/teacher_entities.dart';

/// `{ subjectTeacherId, teacher: { id, name, description?, imageUrl? }, topicsCount?, locked }`
TeacherCard parseTeacherCard(Map<String, Object?> json) {
  final teacher = (json['teacher']! as Map).cast<String, Object?>();
  return TeacherCard(
    subjectTeacherId: json['subjectTeacherId']! as String,
    teacherId: teacher['id']! as String,
    name: teacher['name']! as String,
    description: teacher['description'] as String?,
    imagePath: teacher['imageUrl'] as String?,
    topicsCount: (json['topicsCount'] as num?)?.toInt() ?? 0,
    locked: json['locked']! as bool,
  );
}

List<TeacherCard> parseTeacherCards(Object? data) =>
    (data as List? ?? const []).map((json) => parseTeacherCard((json as Map).cast())).toList();

/// `/student/subject-teachers/:id`
TeacherSpace parseTeacherSpace(Map<String, Object?> json) {
  final teacher = (json['teacher']! as Map).cast<String, Object?>();
  final subject = (json['subject']! as Map).cast<String, Object?>();
  return TeacherSpace(
    subjectTeacherId: json['subjectTeacherId']! as String,
    subjectName: subject['name']! as String,
    teacherName: teacher['name']! as String,
    description: teacher['description'] as String?,
    imagePath: teacher['imageUrl'] as String?,
    topics: parseTopicCards(json['topics']),
    files: parseFiles(json['files']),
  );
}
