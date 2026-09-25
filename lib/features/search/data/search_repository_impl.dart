import '../../../core/network/api_client.dart';
import '../../subjects/data/subject_models.dart';
import '../../teachers/data/teacher_models.dart';
import '../domain/search_entities.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<SearchResults> search(String query) => api.get('/student/search', (data) {
    final json = asMap(data);
    return SearchResults(
      subjects: parseSubjectCards(json['subjects']),
      teachers: parseTeacherCards(json['teachers']),
      topics: asMapList(json['topics'])
          .map((item) => SearchHit(id: item['id']! as String, title: item['title']! as String))
          .toList(),
      sessions: asMapList(json['sessions'])
          .map(
            (item) => SearchHit(
              id: item['id']! as String,
              title: item['title']! as String,
              context: asMap(item['topic'])['title'] as String?,
            ),
          )
          .toList(),
      // For videos, `context` carries the session id so the result opens its session.
      videos: asMapList(json['videos'])
          .map(
            (item) => SearchHit(
              id: item['id']! as String,
              title: item['title']! as String,
              context: asMap(item['session'])['id'] as String?,
              durationSeconds: (item['durationSeconds'] as num?)?.toInt(),
            ),
          )
          .toList(),
    );
  }, query: {'q': query});
}
