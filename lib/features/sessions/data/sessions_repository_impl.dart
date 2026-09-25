import '../../../core/network/api_client.dart';
import '../domain/session_entities.dart';
import 'session_models.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  SessionsRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<SessionDetails> session(String sessionId) =>
      api.get('/student/sessions/$sessionId', (data) => parseSessionDetails(asMap(data)));
}
