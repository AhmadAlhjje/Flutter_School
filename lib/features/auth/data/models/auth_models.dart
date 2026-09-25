import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/student_account.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({required String id, required String name, required String phone, GradeRefModel? grade}) =
      _AccountModel;

  const AccountModel._();

  factory AccountModel.fromJson(Map<String, Object?> json) => _$AccountModelFromJson(json);

  StudentAccount toEntity() => StudentAccount(id: id, name: name, phone: phone, gradeName: grade?.name);
}

@freezed
abstract class GradeRefModel with _$GradeRefModel {
  const factory GradeRefModel({required String id, required String name}) = _GradeRefModel;

  factory GradeRefModel.fromJson(Map<String, Object?> json) => _$GradeRefModelFromJson(json);
}

/// Response of `/auth/student/login`, `/auth/student/register` and `/auth/refresh`.
@freezed
abstract class AppSessionModel with _$AppSessionModel {
  const factory AppSessionModel({required String accessToken, required String refreshToken, AccountModel? user}) =
      _AppSessionModel;

  factory AppSessionModel.fromJson(Map<String, Object?> json) => _$AppSessionModelFromJson(json);
}

@freezed
abstract class PublicConfigModel with _$PublicConfigModel {
  const factory PublicConfigModel({
    required String instituteName,
    @Default(true) bool studentSelfRegistration,
    String? institutePhone,
  }) = _PublicConfigModel;

  const PublicConfigModel._();

  factory PublicConfigModel.fromJson(Map<String, Object?> json) => _$PublicConfigModelFromJson(json);

  PublicConfig toEntity() => PublicConfig(
    instituteName: instituteName,
    selfRegistration: studentSelfRegistration,
    institutePhone: institutePhone,
  );
}
