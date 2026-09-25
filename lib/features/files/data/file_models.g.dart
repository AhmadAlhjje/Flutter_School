// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileItemModel _$FileItemModelFromJson(Map<String, dynamic> json) => _FileItemModel(
  id: json['id'] as String,
  title: json['title'] as String,
  kind: json['kind'] as String,
  extension: json['extension'] as String,
  mimeType: json['mimeType'] as String,
  sizeBytes: (json['sizeBytes'] as num).toInt(),
);

Map<String, dynamic> _$FileItemModelToJson(_FileItemModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'kind': instance.kind,
  'extension': instance.extension,
  'mimeType': instance.mimeType,
  'sizeBytes': instance.sizeBytes,
};

_FileGrantModel _$FileGrantModelFromJson(Map<String, dynamic> json) => _FileGrantModel(
  fileId: json['fileId'] as String,
  title: json['title'] as String,
  kind: json['kind'] as String,
  extension: json['extension'] as String,
  mimeType: json['mimeType'] as String,
  url: json['url'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$FileGrantModelToJson(_FileGrantModel instance) => <String, dynamic>{
  'fileId': instance.fileId,
  'title': instance.title,
  'kind': instance.kind,
  'extension': instance.extension,
  'mimeType': instance.mimeType,
  'url': instance.url,
  'expiresAt': instance.expiresAt.toIso8601String(),
};
