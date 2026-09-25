/// Route paths (spec §109 route guards are applied in app_router.dart).
abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const deviceError = '/device-error';
  static const accountDisabled = '/account-disabled';

  static const home = '/home';
  static const grades = '/grades';
  static const downloads = '/downloads';
  static const profile = '/profile';
  static const changePassword = '/profile/password';
  static const notifications = '/notifications';
  static const search = '/search';
  static const locked = '/locked';

  static String grade(String id) => '/grades/$id';
  static String subject(String id) => '/subjects/$id';
  static String teacher(String subjectTeacherId) => '/teachers/$subjectTeacherId';
  static String topic(String id) => '/topics/$id';
  static String session(String id) => '/sessions/$id';
  static String player(String videoId) => '/player/$videoId';
  static String offlinePlayer(String licenseId) => '/downloads/$licenseId/play';
  static String file(String id) => '/files/$id';

  /// Screens reachable without a session.
  static const publicPaths = {splash, login, register, deviceError, accountDisabled};
}
