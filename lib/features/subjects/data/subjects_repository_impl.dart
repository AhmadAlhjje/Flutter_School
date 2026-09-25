import '../../../core/network/api_client.dart';
import '../domain/subject_entities.dart';
import 'subject_models.dart';

class SubjectsRepositoryImpl implements SubjectsRepository {
  SubjectsRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<SubjectDetails> subject(String subjectId) =>
      api.get('/student/subjects/$subjectId', (data) => parseSubjectDetails(asMap(data)));
}
