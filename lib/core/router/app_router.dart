import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/device/presentation/blocked_pages.dart';
import '../../features/files/presentation/file_viewer_page.dart';
import '../../features/grades/presentation/grades_pages.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/notifications/presentation/notifications_page.dart';
import '../../features/profile/presentation/profile_pages.dart';
import '../../features/search/presentation/search_page.dart';
import '../../features/sessions/presentation/session_page.dart';
import '../../features/subjects/presentation/subject_page.dart';
import '../../features/teachers/presentation/teacher_page.dart';
import '../../features/topics/presentation/topic_page.dart';
import '../../features/videos/presentation/downloads_page.dart';
import '../../features/videos/presentation/video_player_page.dart';
import '../../shared/widgets/locked_content.dart';
import 'routes.dart';

/// Where the app must be for a given session state (spec §101 access flow).
/// Pure function so it can be unit-tested without widgets.
String? redirectFor(AuthState auth, String location) {
  switch (auth) {
    case AuthUnknown():
      return location == Routes.splash ? null : Routes.splash;
    case AuthDeviceBlocked():
      return location == Routes.deviceError ? null : Routes.deviceError;
    case AuthAccountDisabled():
      return location == Routes.accountDisabled ? null : Routes.accountDisabled;
    case AuthSignedOut():
      return location == Routes.login || location == Routes.register ? null : Routes.login;
    case AuthSignedIn():
      return Routes.publicPaths.contains(location) ? Routes.home : null;
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ValueNotifier<AuthState>(ref.read(authControllerProvider));
  ref.listen(authControllerProvider, (_, next) => auth.value = next);
  ref.onDispose(auth.dispose);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: auth,
    redirect: (context, state) => redirectFor(auth.value, state.matchedLocation),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashPage()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginPage()),
      GoRoute(path: Routes.register, builder: (_, _) => const RegisterPage()),
      GoRoute(path: Routes.deviceError, builder: (_, _) => const DeviceErrorPage()),
      GoRoute(path: Routes.accountDisabled, builder: (_, _) => const AccountDisabledPage()),
      GoRoute(path: Routes.home, builder: (_, _) => const HomePage()),
      GoRoute(path: Routes.grades, builder: (_, _) => const GradesPage()),
      GoRoute(
        path: '/grades/:gradeId',
        builder: (_, state) => GradeSubjectsPage(gradeId: state.pathParameters['gradeId']!),
      ),
      GoRoute(
        path: '/subjects/:subjectId',
        builder: (_, state) => SubjectPage(subjectId: state.pathParameters['subjectId']!),
      ),
      GoRoute(
        path: '/teachers/:subjectTeacherId',
        builder: (_, state) => TeacherPage(subjectTeacherId: state.pathParameters['subjectTeacherId']!),
      ),
      GoRoute(
        path: '/topics/:topicId',
        builder: (_, state) => TopicPage(topicId: state.pathParameters['topicId']!),
      ),
      GoRoute(
        path: '/sessions/:sessionId',
        builder: (_, state) => SessionPage(sessionId: state.pathParameters['sessionId']!),
      ),
      GoRoute(
        path: '/player/:videoId',
        builder: (_, state) => VideoPlayerPage.online(videoId: state.pathParameters['videoId']!),
      ),
      GoRoute(path: Routes.downloads, builder: (_, _) => const DownloadsPage()),
      GoRoute(
        path: '/downloads/:licenseId/play',
        builder: (_, state) => VideoPlayerPage.offline(licenseId: state.pathParameters['licenseId']!),
      ),
      GoRoute(
        path: '/files/:fileId',
        builder: (_, state) =>
            FileViewerPage(fileId: state.pathParameters['fileId']!, title: state.uri.queryParameters['title']),
      ),
      GoRoute(path: Routes.profile, builder: (_, _) => const ProfilePage()),
      GoRoute(path: Routes.changePassword, builder: (_, _) => const ChangePasswordPage()),
      GoRoute(path: Routes.notifications, builder: (_, _) => const NotificationsPage()),
      GoRoute(path: Routes.search, builder: (_, _) => const SearchPage()),
      GoRoute(
        path: Routes.locked,
        builder: (_, state) => LockedContentPage(title: state.uri.queryParameters['title']),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
