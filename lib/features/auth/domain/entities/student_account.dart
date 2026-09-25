import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_account.freezed.dart';

/// The signed-in student (domain entity — no JSON, no Flutter).
@freezed
abstract class StudentAccount with _$StudentAccount {
  const factory StudentAccount({required String id, required String name, required String phone, String? gradeName}) =
      _StudentAccount;
}

/// Public institute configuration shown before sign-in.
@freezed
abstract class PublicConfig with _$PublicConfig {
  const factory PublicConfig({required String instituteName, required bool selfRegistration, String? institutePhone}) =
      _PublicConfig;
}
