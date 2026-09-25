import '../../../core/network/api_client.dart';
import '../domain/file_entities.dart';
import 'file_models.dart';

class FilesRepositoryImpl implements FilesRepository {
  FilesRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<FileGrant> requestAccess(String fileId) =>
      api.post('/student/files/$fileId/access', (data) => FileGrantModel.fromJson(asMap(data)).toEntity());

  @override
  Future<List<int>> download(FileGrant grant, {void Function(double progress)? onProgress}) => api.bytes(
    grant.url,
    onProgress: onProgress == null ? null : (received, total) => total > 0 ? onProgress(received / total) : null,
  );
}
