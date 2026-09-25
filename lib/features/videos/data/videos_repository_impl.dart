import '../../../core/network/api_client.dart';
import '../domain/video_entities.dart';
import 'video_models.dart';

class VideosRepositoryImpl implements VideosRepository {
  VideosRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<PlaybackGrant> requestPlayback(String videoId) =>
      api.post('/student/videos/$videoId/playback', (data) => parsePlaybackGrant(asMap(data)));
}
