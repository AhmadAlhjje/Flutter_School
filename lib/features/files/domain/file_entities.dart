import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_entities.freezed.dart';

enum FileKind { pdf, document, presentation, spreadsheet, archive, image, other }

/// An educational file attached to a subject, teacher space, lesson or session.
@freezed
abstract class FileItem with _$FileItem {
  const factory FileItem({
    required String id,
    required String title,
    required FileKind kind,
    required String extension,
    required String mimeType,
    required int sizeBytes,
  }) = _FileItem;
}

/// A short-lived, access-checked download URL (spec §40).
@freezed
abstract class FileGrant with _$FileGrant {
  const factory FileGrant({
    required String fileId,
    required String title,
    required FileKind kind,
    required String extension,
    required String mimeType,
    required String url,
    required DateTime expiresAt,
  }) = _FileGrant;
}

abstract interface class FilesRepository {
  /// Asks the server for a download URL; fails with access-denied for locked content.
  Future<FileGrant> requestAccess(String fileId);

  /// Downloads the file into memory (never into shared storage).
  Future<List<int>> download(FileGrant grant, {void Function(double progress)? onProgress});
}
