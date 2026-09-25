import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entities.freezed.dart';

@freezed
abstract class StudentProfile with _$StudentProfile {
  const factory StudentProfile({
    required String name,
    required String phone,
    required int openSubjectsCount,
    required int openTeachersCount,
    String? gradeName,
    String? deviceModel,
    String? devicePlatform,
    DateTime? deviceBoundAt,
  }) = _StudentProfile;
}

abstract interface class ProfileRepository {
  Future<StudentProfile> profile();
}
