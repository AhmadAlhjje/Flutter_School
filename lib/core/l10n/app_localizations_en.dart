// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Educational Institute';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get close => 'Close';

  @override
  String get errorLoading => 'Something went wrong while loading';

  @override
  String get errorNetwork =>
      'Cannot reach the server, check your internet connection';

  @override
  String get errorGeneric => 'Something went wrong, please try again';

  @override
  String get errorInvalidCredentials => 'Invalid phone number or password';

  @override
  String get errorSessionExpired => 'Your session ended, please sign in again';

  @override
  String get errorAccessDenied => 'This content is locked';

  @override
  String get errorNotFound => 'This content no longer exists';

  @override
  String get errorVideoNotReady => 'The video is not ready yet';

  @override
  String get errorRateLimited => 'Too many attempts, please wait a moment';

  @override
  String get errorPhoneTaken => 'This phone number is already registered';

  @override
  String get errorRegistrationDisabled =>
      'Registration is not available, contact the institute';

  @override
  String get errorWeakPassword =>
      'Weak password: at least 8 characters with letters and digits';

  @override
  String get errorInvalidCurrentPassword => 'Current password is incorrect';

  @override
  String get errorOfflineDisabled => 'Offline downloads are not available';

  @override
  String get errorValidation => 'Invalid input';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidPhone => 'Invalid phone number';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordHint => 'At least 8 characters with letters and digits';

  @override
  String get loginTitle => 'Sign in';

  @override
  String loginSubtitle(String institute) {
    return 'Welcome to $institute';
  }

  @override
  String get phone => 'Phone number';

  @override
  String get password => 'Password';

  @override
  String get login => 'Sign in';

  @override
  String get noAccount => 'No account yet?';

  @override
  String get registerTitle => 'Create a new account';

  @override
  String get fullName => 'Full name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get register => 'Register';

  @override
  String get haveAccount => 'Already registered?';

  @override
  String get deviceNotice =>
      'Your account will be linked to this device on first sign-in.';

  @override
  String get logout => 'Sign out';

  @override
  String get logoutConfirm => 'Do you want to sign out?';

  @override
  String get deviceErrorTitle => 'Account linked to another device';

  @override
  String get deviceErrorBody =>
      'This account can only be used on its linked device. To change the device, please contact the institute.';

  @override
  String get accountDisabledTitle => 'Account disabled';

  @override
  String get accountDisabledBody =>
      'Your account has been disabled. Please contact the institute.';

  @override
  String get backToLogin => 'Back to sign in';

  @override
  String helloName(String name) {
    return 'Hello $name 👋';
  }

  @override
  String get grades => 'Grades';

  @override
  String teachersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teachers',
      one: '1 teacher',
    );
    return '$_temp0';
  }

  @override
  String topicsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lessons',
      one: '1 lesson',
    );
    return '$_temp0';
  }

  @override
  String sessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
    );
    return '$_temp0';
  }

  @override
  String videosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count videos',
      one: '1 video',
    );
    return '$_temp0';
  }

  @override
  String filesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files',
      one: '1 file',
    );
    return '$_temp0';
  }

  @override
  String get locked => 'Locked';

  @override
  String get open => 'Open';

  @override
  String get lockedTitle => 'Content locked';

  @override
  String get lockedBody =>
      'This content is not available to you yet. Contact the institute to unlock it.';

  @override
  String get teachers => 'Teachers';

  @override
  String get noTeachers => 'No teachers in this subject';

  @override
  String teacherTitle(String name) {
    return 'Teacher $name';
  }

  @override
  String get lessons => 'Lessons';

  @override
  String get noLessons => 'No lessons yet';

  @override
  String get sessions => 'Sessions';

  @override
  String get noSessions => 'No sessions yet';

  @override
  String get videos => 'Videos';

  @override
  String get files => 'Files';

  @override
  String get playerError => 'Could not play the video';

  @override
  String get captureBlocked =>
      'The video cannot play while the screen is being recorded. Stop recording to continue.';

  @override
  String get downloadOffline => 'Download for offline viewing';

  @override
  String downloadingPercent(int percent) {
    return 'Downloading $percent%';
  }

  @override
  String get downloaded => 'Downloaded';

  @override
  String get downloadFailed => 'Download failed';

  @override
  String get deleteDownload => 'Delete download';

  @override
  String get noDownloads => 'No downloads';

  @override
  String availableUntil(String date) {
    return 'Available until $date';
  }

  @override
  String get downloadExpired => 'Download expired, go online to renew it';

  @override
  String get openFile => 'Open file';

  @override
  String get fileOpensExternally =>
      'This file opens in another app on your device';

  @override
  String get profile => 'Profile';

  @override
  String get changePassword => 'Change password';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get passwordChanged => 'Password changed successfully';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get notifications => 'Notifications';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get markAllRead => 'Mark all as read';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search for a lesson...';

  @override
  String get searchMinChars => 'Type at least 2 characters';

  @override
  String get searchNoResults => 'No results';

  @override
  String get searchSubjects => 'Subjects';

  @override
  String get searchTeachers => 'Teachers';

  @override
  String get searchLessons => 'Lessons';

  @override
  String get searchSessions => 'Sessions';

  @override
  String get searchVideos => 'Videos';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get rewind10 => 'Back 10 seconds';

  @override
  String get forward10 => 'Forward 10 seconds';

  @override
  String get fullscreen => 'Fullscreen';

  @override
  String get exitFullscreen => 'Exit fullscreen';

  @override
  String get deleteDownloadConfirm =>
      'This video will be removed from your device. You can download it again later.';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get passwordChangeNote =>
      'Any other session of your account will be signed out.';

  @override
  String get markRead => 'Mark as read';

  @override
  String get loadMore => 'Load more';

  @override
  String get fileTooLargeToPreview =>
      'This file cannot be previewed in the app';

  @override
  String get noAppToOpenFile => 'No app on your device can open this file type';

  @override
  String get downloadingFile => 'Downloading file...';

  @override
  String get screenshotDetected =>
      'Screenshot detected. This content is protected and linked to your account.';

  @override
  String get noVideos => 'No videos yet';

  @override
  String get noFiles => 'No files';

  @override
  String get downloadedOnDevice => 'On this device';

  @override
  String get offlineTitle => 'You\'re offline';

  @override
  String get offlineBody =>
      'You can watch the videos downloaded on this device';

  @override
  String get navHome => 'Home';

  @override
  String get navAccount => 'My account';

  @override
  String get homeSubtitle => 'Choose a subject to study';

  @override
  String get mySubjects => 'My subjects';

  @override
  String get otherSubjects => 'Other subjects';

  @override
  String get otherSubjectsHint =>
      'These subjects are locked for now; contact the institute to open them';

  @override
  String get noSubjectsTitle =>
      'Your account is ready! No subjects are open yet';

  @override
  String get noSubjectsBody =>
      'As soon as the institute opens subjects for your account, they appear here.';

  @override
  String contactInstitute(String phone) {
    return 'Contact the institute: $phone';
  }

  @override
  String get lockedHint => 'Locked — contact the institute to open it';

  @override
  String get hintChooseTeacher => 'Choose a teacher to see their lessons';

  @override
  String get hintChooseLesson => 'Choose a lesson';

  @override
  String get hintChooseSession =>
      'Choose a session to see its videos and files';

  @override
  String get hintVideos =>
      'Tap a video to watch it, or \"Download\" to watch it later without internet';

  @override
  String get hintFiles => 'Tap a file to open it';

  @override
  String get download => 'Download';

  @override
  String get downloadedShort => 'Saved';

  @override
  String get retryShort => 'Retry';

  @override
  String get createAccountButton => 'Create a new account';

  @override
  String get yourGrade => 'Your grade';

  @override
  String get chooseGrade => 'Choose your grade';

  @override
  String get gradesUnavailable => 'Could not load the grades';

  @override
  String get playbackSpeed => 'Playback speed';

  @override
  String get findSubject => 'Search subjects by name';

  @override
  String get findLesson => 'Search lessons by name';

  @override
  String get findSession => 'Search sessions by name';

  @override
  String lessonNumber(int number) {
    return 'Lesson $number';
  }

  @override
  String get downloadPreparing => 'Starting the download...';

  @override
  String get navHistory => 'My videos';

  @override
  String get historyHint => 'Tap a video to continue where you stopped';

  @override
  String get historyEmpty =>
      'You have not watched any video yet.\nVideos you watch appear here, to continue where you stopped.';

  @override
  String get watchedFully => 'Watched to the end';

  @override
  String continueFrom(String time) {
    return 'Continue from $time';
  }

  @override
  String continuedFrom(String time) {
    return 'Continued where you stopped ($time)';
  }

  @override
  String get startOver => 'Start over';

  @override
  String get removeFromHistory => 'Remove from the list';

  @override
  String videoDownloaded(String title) {
    return '“$title” downloaded ✓ you can watch it offline';
  }

  @override
  String videoDownloadFailed(String title) {
    return 'Could not download “$title”, try again';
  }

  @override
  String get downloadDeleted => 'The video was removed from your phone';

  @override
  String get backOnline => 'Back online ✓ content updated';

  @override
  String get offlineSavedCopy =>
      'You are offline — showing the last saved content';

  @override
  String get offlineDownloads => 'Downloads on your phone';
}
