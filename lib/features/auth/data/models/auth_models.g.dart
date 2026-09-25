// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => _AccountModel(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  grade: json['grade'] == null ? null : GradeRefModel.fromJson(json['grade'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'grade': instance.grade,
};

_GradeRefModel _$GradeRefModelFromJson(Map<String, dynamic> json) =>
    _GradeRefModel(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$GradeRefModelToJson(_GradeRefModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

_AppSessionModel _$AppSessionModelFromJson(Map<String, dynamic> json) => _AppSessionModel(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  user: json['user'] == null ? null : AccountModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppSessionModelToJson(_AppSessionModel instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'user': instance.user,
};

_PublicConfigModel _$PublicConfigModelFromJson(Map<String, dynamic> json) => _PublicConfigModel(
  instituteName: json['instituteName'] as String,
  studentSelfRegistration: json['studentSelfRegistration'] as bool? ?? false,
);

Map<String, dynamic> _$PublicConfigModelToJson(_PublicConfigModel instance) => <String, dynamic>{
  'instituteName': instance.instituteName,
  'studentSelfRegistration': instance.studentSelfRegistration,
};
