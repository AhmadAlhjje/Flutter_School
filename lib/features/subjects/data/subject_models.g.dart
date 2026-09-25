// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectCardModel _$SubjectCardModelFromJson(Map<String, dynamic> json) => _SubjectCardModel(
  id: json['id'] as String,
  name: json['name'] as String,
  gradeName: json['gradeName'] as String,
  teachersCount: (json['teachersCount'] as num).toInt(),
  locked: json['locked'] as bool,
  description: json['description'] as String?,
);

Map<String, dynamic> _$SubjectCardModelToJson(_SubjectCardModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'gradeName': instance.gradeName,
  'teachersCount': instance.teachersCount,
  'locked': instance.locked,
  'description': instance.description,
};
