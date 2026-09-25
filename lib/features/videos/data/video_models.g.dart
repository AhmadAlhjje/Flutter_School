// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoItemModel _$VideoItemModelFromJson(Map<String, dynamic> json) => _VideoItemModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$VideoItemModelToJson(_VideoItemModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'durationSeconds': instance.durationSeconds,
};
