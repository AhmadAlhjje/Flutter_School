import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/api_client.dart';
import '../core/network/network_providers.dart';
import 'files/data/files_repository_impl.dart';
import 'files/domain/file_entities.dart';
import 'grades/data/grades_repository_impl.dart';
import 'grades/domain/grade_entities.dart';
import 'home/data/home_repository_impl.dart';
import 'home/domain/home_entities.dart';
import 'notifications/data/notifications_repository_impl.dart';
import 'notifications/domain/notification_entities.dart';
import 'profile/data/profile_repository_impl.dart';
import 'profile/domain/profile_entities.dart';
import 'search/data/search_repository_impl.dart';
import 'search/domain/search_entities.dart';
import 'sessions/data/sessions_repository_impl.dart';
import 'sessions/domain/session_entities.dart';
import 'subjects/data/subjects_repository_impl.dart';
import 'subjects/domain/subject_entities.dart';
import 'teachers/data/teachers_repository_impl.dart';
import 'teachers/domain/teacher_entities.dart';
import 'topics/data/topics_repository_impl.dart';
import 'topics/domain/topic_entities.dart';
import 'videos/data/videos_repository_impl.dart';
import 'videos/domain/video_entities.dart';

/// Composition root for the learning features: each provider exposes a domain contract bound
/// to its data implementation. Presentation code depends on these domain types only.
ApiClient _api(Ref ref) => ref.watch(apiClientProvider);

final homeRepositoryProvider = Provider<HomeRepository>((ref) => HomeRepositoryImpl(_api(ref)));
final gradesRepositoryProvider = Provider<GradesRepository>((ref) => GradesRepositoryImpl(_api(ref)));
final subjectsRepositoryProvider = Provider<SubjectsRepository>((ref) => SubjectsRepositoryImpl(_api(ref)));
final teachersRepositoryProvider = Provider<TeachersRepository>((ref) => TeachersRepositoryImpl(_api(ref)));
final topicsRepositoryProvider = Provider<TopicsRepository>((ref) => TopicsRepositoryImpl(_api(ref)));
final sessionsRepositoryProvider = Provider<SessionsRepository>((ref) => SessionsRepositoryImpl(_api(ref)));
final videosRepositoryProvider = Provider<VideosRepository>((ref) => VideosRepositoryImpl(_api(ref)));
final filesRepositoryProvider = Provider<FilesRepository>((ref) => FilesRepositoryImpl(_api(ref)));
final profileRepositoryProvider = Provider<ProfileRepository>((ref) => ProfileRepositoryImpl(_api(ref)));
final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepositoryImpl(_api(ref)),
);
final searchRepositoryProvider = Provider<SearchRepository>((ref) => SearchRepositoryImpl(_api(ref)));
