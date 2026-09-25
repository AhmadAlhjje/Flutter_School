import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/file_entities.dart';

part 'file_models.freezed.dart';
part 'file_models.g.dart';

FileKind parseFileKind(String value) => switch (value) {
  'PDF' => FileKind.pdf,
  'DOCUMENT' => FileKind.document,
  'PRESENTATION' => FileKind.presentation,
  'SPREADSHEET' => FileKind.spreadsheet,
  'ARCHIVE' => FileKind.archive,
  'IMAGE' => FileKind.image,
  _ => FileKind.other,
};

@freezed
abstract class FileItemModel with _$FileItemModel {
  const factory FileItemModel({
    required String id,
    required String title,
    required String kind,
    required String extension,
    required String mimeType,
    required int sizeBytes,
  }) = _FileItemModel;

  const FileItemModel._();

  factory FileItemModel.fromJson(Map<String, Object?> json) => _$FileItemModelFromJson(json);

  FileItem toEntity() => FileItem(
    id: id,
    title: title,
    kind: parseFileKind(kind),
    extension: extension,
    mimeType: mimeType,
    sizeBytes: sizeBytes,
  );
}

@freezed
abstract class FileGrantModel with _$FileGrantModel {
  const factory FileGrantModel({
    required String fileId,
    required String title,
    required String kind,
    required String extension,
    required String mimeType,
    required String url,
    required DateTime expiresAt,
  }) = _FileGrantModel;

  const FileGrantModel._();

  factory FileGrantModel.fromJson(Map<String, Object?> json) => _$FileGrantModelFromJson(json);

  FileGrant toEntity() => FileGrant(
    fileId: fileId,
    title: title,
    kind: parseFileKind(kind),
    extension: extension,
    mimeType: mimeType,
    url: url,
    expiresAt: expiresAt,
  );
}

List<FileItem> parseFiles(Object? data) =>
    (data as List? ?? const []).map((json) => FileItemModel.fromJson((json as Map).cast()).toEntity()).toList();
