import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'catalog_repositories.dart';
import 'grades/domain/grade_entities.dart';
import 'home/domain/home_entities.dart';
import 'notifications/domain/notification_entities.dart';
import 'profile/domain/profile_entities.dart';
import 'search/domain/search_entities.dart';
import 'sessions/domain/session_entities.dart';
import 'subjects/domain/subject_entities.dart';
import 'teachers/domain/teacher_entities.dart';
import 'topics/domain/topic_entities.dart';
import 'videos/domain/video_entities.dart';

/// Read models for the learning screens. Auto-disposed so leaving a screen drops its data and
/// returning fetches fresh access state from the server (a closed teacher disappears at once).
final homeProvider = FutureProvider.autoDispose<HomeSummary>((ref) => ref.watch(homeRepositoryProvider).home());

final gradesProvider = FutureProvider.autoDispose<List<GradeSummary>>(
  (ref) => ref.watch(gradesRepositoryProvider).grades(),
);

final gradeSubjectsProvider = FutureProvider.autoDispose.family<GradeSubjects, String>(
  (ref, gradeId) => ref.watch(gradesRepositoryProvider).gradeSubjects(gradeId),
);

final subjectProvider = FutureProvider.autoDispose.family<SubjectDetails, String>(
  (ref, subjectId) => ref.watch(subjectsRepositoryProvider).subject(subjectId),
);

final teacherSpaceProvider = FutureProvider.autoDispose.family<TeacherSpace, String>(
  (ref, subjectTeacherId) => ref.watch(teachersRepositoryProvider).teacherSpace(subjectTeacherId),
);

final topicProvider = FutureProvider.autoDispose.family<TopicDetails, String>(
  (ref, topicId) => ref.watch(topicsRepositoryProvider).topic(topicId),
);

final sessionProvider = FutureProvider.autoDispose.family<SessionDetails, String>(
  (ref, sessionId) => ref.watch(sessionsRepositoryProvider).session(sessionId),
);

final playbackProvider = FutureProvider.autoDispose.family<PlaybackGrant, String>(
  (ref, videoId) => ref.watch(videosRepositoryProvider).requestPlayback(videoId),
);

final profileProvider = FutureProvider.autoDispose<StudentProfile>(
  (ref) => ref.watch(profileRepositoryProvider).profile(),
);

final unreadCountProvider = FutureProvider.autoDispose<int>(
  (ref) => ref.watch(notificationsRepositoryProvider).unreadCount(),
);

final inboxProvider = FutureProvider.autoDispose<InboxPage>(
  (ref) => ref.watch(notificationsRepositoryProvider).inbox(),
);

final searchResultsProvider = FutureProvider.autoDispose.family<SearchResults, String>(
  (ref, query) => ref.watch(searchRepositoryProvider).search(query),
);
