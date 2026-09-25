import '../../../core/network/api_client.dart';
import '../../../core/network/transfer.dart';
import '../domain/file_entities.dart';
import 'file_models.dart';

class FilesRepositoryImpl implements FilesRepository {
  FilesRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<FileGrant> requestAccess(String fileId) =>
      api.post('/student/files/$fileId/access', (data) => FileGrantModel.fromJson(asMap(data)).toEntity());

  /// Parallel download; the 5-minute URL is renewed if a large file outlasts it.
  @override
  Future<List<int>> download(FileGrant grant, {void Function(TransferProgress progress)? onProgress}) =>
      api.parallelBytes(
        grant.url,
        onProgress: onProgress,
        refreshUrl: () async => (await requestAccess(grant.fileId)).url,
      );
}
