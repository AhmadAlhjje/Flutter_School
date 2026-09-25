import '../../../core/network/api_client.dart';
import '../../grades/data/grades_repository_impl.dart';
import '../../subjects/data/subject_models.dart';
import '../domain/home_entities.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<HomeSummary> home() => api.get('/student/home', (data) {
    final json = asMap(data);
    return HomeSummary(
      studentName: asMap(json['student'])['name']! as String,
      instituteName: asMap(json['institute'])['name']! as String,
      unreadNotifications: (json['unreadNotifications'] as num?)?.toInt() ?? 0,
      subjects: parseSubjectCards(json['subjects']),
      grades: parseGradeSummaries(json['grades']),
    );
  });
}
