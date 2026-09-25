import '../../../core/network/api_client.dart';
import '../domain/topic_entities.dart';
import 'topic_models.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  TopicsRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<TopicDetails> topic(String topicId) =>
      api.get('/student/topics/$topicId', (data) => parseTopicDetails(asMap(data)));
}
