import '../../../core/network/api_client.dart';
import '../domain/profile_entities.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this.api);

  final ApiClient api;

  @override
  Future<StudentProfile> profile() => api.get('/student/profile', (data) {
    final json = asMap(data);
    final grade = json['grade'] as Map?;
    final device = json['device'] as Map?;
    final boundAt = device?['firstSeenAt'] as String?;
    return StudentProfile(
      name: json['name']! as String,
      phone: json['phone']! as String,
      gradeName: grade?['name'] as String?,
      openSubjectsCount: (json['openSubjectsCount'] as num?)?.toInt() ?? 0,
      openTeachersCount: (json['openTeachersCount'] as num?)?.toInt() ?? 0,
      deviceModel: device?['model'] as String?,
      devicePlatform: device?['platform'] as String?,
      deviceBoundAt: boundAt == null ? null : DateTime.parse(boundAt),
    );
  });
}
