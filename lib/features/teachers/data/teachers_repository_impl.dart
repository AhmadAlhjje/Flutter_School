import '../../../core/network/api_client.dart';
import '../domain/teacher_entities.dart';
import 'teacher_models.dart';

class TeachersRepositoryImpl implements TeachersRepository {
  TeachersRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<TeacherSpace> teacherSpace(String subjectTeacherId) =>
      api.get('/student/subject-teachers/$subjectTeacherId', (data) => parseTeacherSpace(asMap(data)));
}
