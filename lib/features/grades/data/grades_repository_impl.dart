import '../../../core/network/api_client.dart';
import '../../subjects/data/subject_models.dart';
import '../domain/grade_entities.dart';

class GradesRepositoryImpl implements GradesRepository {
  GradesRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<List<GradeSummary>> grades() => api.get('/student/grades', parseGradeSummaries);

  @override
  Future<GradeSubjects> gradeSubjects(String gradeId) => api.get('/student/grades/$gradeId/subjects', (data) {
    final json = asMap(data);
    final grade = asMap(json['grade']);
    return GradeSubjects(
      gradeId: grade['id']! as String,
      gradeName: grade['name']! as String,
      subjects: parseSubjectCards(json['subjects']),
    );
  });
}

List<GradeSummary> parseGradeSummaries(Object? data) => asMapList(data)
    .map(
      (json) => GradeSummary(
        id: json['id']! as String,
        name: json['name']! as String,
        subjectsCount: (json['subjectsCount'] as num?)?.toInt() ?? 0,
      ),
    )
    .toList();
