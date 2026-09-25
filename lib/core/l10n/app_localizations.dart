import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar'), Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'المعهد التعليمي'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @close.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get close;

  /// No description provided for @errorLoading.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء تحميل البيانات'**
  String get errorLoading;

  /// No description provided for @errorNetwork.
  ///
  /// In ar, this message translates to:
  /// **'تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت'**
  String get errorNetwork;

  /// No description provided for @errorGeneric.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما، حاول مرة أخرى'**
  String get errorGeneric;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف أو كلمة المرور غير صحيحة'**
  String get errorInvalidCredentials;

  /// No description provided for @errorSessionExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت الجلسة، يرجى تسجيل الدخول مجدداً'**
  String get errorSessionExpired;

  /// No description provided for @errorAccessDenied.
  ///
  /// In ar, this message translates to:
  /// **'هذا المحتوى مقفل'**
  String get errorAccessDenied;

  /// No description provided for @errorNotFound.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى غير موجود أو لم يعد متاحاً'**
  String get errorNotFound;

  /// No description provided for @errorVideoNotReady.
  ///
  /// In ar, this message translates to:
  /// **'الفيديو غير جاهز بعد'**
  String get errorVideoNotReady;

  /// No description provided for @errorRateLimited.
  ///
  /// In ar, this message translates to:
  /// **'محاولات كثيرة، يرجى الانتظار قليلاً'**
  String get errorRateLimited;

  /// No description provided for @errorPhoneTaken.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف مستخدم مسبقاً'**
  String get errorPhoneTaken;

  /// No description provided for @errorRegistrationDisabled.
  ///
  /// In ar, this message translates to:
  /// **'التسجيل غير متاح حالياً، تواصل مع إدارة المعهد'**
  String get errorRegistrationDisabled;

  /// No description provided for @errorWeakPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور ضعيفة: 8 أحرف على الأقل وتحتوي على حروف وأرقام'**
  String get errorWeakPassword;

  /// No description provided for @errorInvalidCurrentPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية غير صحيحة'**
  String get errorInvalidCurrentPassword;

  /// No description provided for @errorOfflineDisabled.
  ///
  /// In ar, this message translates to:
  /// **'التحميل للمشاهدة دون إنترنت غير متاح'**
  String get errorOfflineDisabled;

  /// No description provided for @errorValidation.
  ///
  /// In ar, this message translates to:
  /// **'البيانات المدخلة غير صحيحة'**
  String get errorValidation;

  /// No description provided for @fieldRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get fieldRequired;

  /// No description provided for @invalidPhone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف غير صالح'**
  String get invalidPhone;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordHint.
  ///
  /// In ar, this message translates to:
  /// **'8 أحرف على الأقل، وتحتوي على حروف وأرقام'**
  String get passwordHint;

  /// No description provided for @loginTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك في {institute}'**
  String loginSubtitle(String institute);

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phone;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'دخول'**
  String get login;

  /// No description provided for @noAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get noAccount;

  /// No description provided for @registerTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get registerTitle;

  /// No description provided for @fullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل'**
  String get register;

  /// No description provided for @haveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب؟'**
  String get haveAccount;

  /// No description provided for @deviceNotice.
  ///
  /// In ar, this message translates to:
  /// **'سيتم ربط حسابك بهذا الجهاز عند أول تسجيل دخول.'**
  String get deviceNotice;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل الخروج؟'**
  String get logoutConfirm;

  /// No description provided for @deviceErrorTitle.
  ///
  /// In ar, this message translates to:
  /// **'الحساب مرتبط بجهاز آخر'**
  String get deviceErrorTitle;

  /// No description provided for @deviceErrorBody.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن استخدام هذا الحساب إلا على الجهاز المرتبط به. لتغيير الجهاز يرجى التواصل مع إدارة المعهد.'**
  String get deviceErrorBody;

  /// No description provided for @accountDisabledTitle.
  ///
  /// In ar, this message translates to:
  /// **'الحساب معطّل'**
  String get accountDisabledTitle;

  /// No description provided for @accountDisabledBody.
  ///
  /// In ar, this message translates to:
  /// **'تم تعطيل حسابك. يرجى التواصل مع إدارة المعهد.'**
  String get accountDisabledBody;

  /// No description provided for @backToLogin.
  ///
  /// In ar, this message translates to:
  /// **'العودة لتسجيل الدخول'**
  String get backToLogin;

  /// No description provided for @helloName.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً {name} 👋'**
  String helloName(String name);

  /// No description provided for @grades.
  ///
  /// In ar, this message translates to:
  /// **'الصفوف'**
  String get grades;

  /// No description provided for @teachersCount.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا مدرسين} =1{مدرس واحد} =2{مدرسان} few{{count} مدرسين} many{{count} مدرساً} other{{count} مدرس}}'**
  String teachersCount(int count);

  /// No description provided for @topicsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا دروس} =1{درس واحد} =2{درسان} few{{count} دروس} many{{count} درساً} other{{count} درس}}'**
  String topicsCount(int count);

  /// No description provided for @sessionsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا جلسات} =1{جلسة واحدة} =2{جلستان} few{{count} جلسات} many{{count} جلسة} other{{count} جلسة}}'**
  String sessionsCount(int count);

  /// No description provided for @videosCount.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا فيديوهات} =1{فيديو واحد} =2{فيديوهان} few{{count} فيديوهات} many{{count} فيديو} other{{count} فيديو}}'**
  String videosCount(int count);

  /// No description provided for @filesCount.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا ملفات} =1{ملف واحد} =2{ملفان} few{{count} ملفات} many{{count} ملفاً} other{{count} ملف}}'**
  String filesCount(int count);

  /// No description provided for @locked.
  ///
  /// In ar, this message translates to:
  /// **'مقفل'**
  String get locked;

  /// No description provided for @open.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح'**
  String get open;

  /// No description provided for @lockedTitle.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى مقفل'**
  String get lockedTitle;

  /// No description provided for @lockedBody.
  ///
  /// In ar, this message translates to:
  /// **'هذا المحتوى غير متاح لك حالياً. تواصل مع إدارة المعهد لفتحه.'**
  String get lockedBody;

  /// No description provided for @teachers.
  ///
  /// In ar, this message translates to:
  /// **'المدرسين'**
  String get teachers;

  /// No description provided for @noTeachers.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مدرسون في هذه المادة'**
  String get noTeachers;

  /// No description provided for @teacherTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأستاذ {name}'**
  String teacherTitle(String name);

  /// No description provided for @lessons.
  ///
  /// In ar, this message translates to:
  /// **'الدروس'**
  String get lessons;

  /// No description provided for @noLessons.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد دروس بعد'**
  String get noLessons;

  /// No description provided for @sessions.
  ///
  /// In ar, this message translates to:
  /// **'الجلسات'**
  String get sessions;

  /// No description provided for @noSessions.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد جلسات بعد'**
  String get noSessions;

  /// No description provided for @videos.
  ///
  /// In ar, this message translates to:
  /// **'الفيديوهات'**
  String get videos;

  /// No description provided for @files.
  ///
  /// In ar, this message translates to:
  /// **'الملفات'**
  String get files;

  /// No description provided for @playerError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تشغيل الفيديو'**
  String get playerError;

  /// No description provided for @captureBlocked.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن تشغيل الفيديو أثناء تسجيل الشاشة. أوقف التسجيل للمتابعة.'**
  String get captureBlocked;

  /// No description provided for @downloadOffline.
  ///
  /// In ar, this message translates to:
  /// **'تحميل للمشاهدة دون إنترنت'**
  String get downloadOffline;

  /// No description provided for @downloadingPercent.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل {percent}%'**
  String downloadingPercent(int percent);

  /// No description provided for @downloaded.
  ///
  /// In ar, this message translates to:
  /// **'تم التحميل'**
  String get downloaded;

  /// No description provided for @downloadFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل التحميل'**
  String get downloadFailed;

  /// No description provided for @deleteDownload.
  ///
  /// In ar, this message translates to:
  /// **'حذف التحميل'**
  String get deleteDownload;

  /// No description provided for @noDownloads.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تحميلات'**
  String get noDownloads;

  /// No description provided for @availableUntil.
  ///
  /// In ar, this message translates to:
  /// **'متاح حتى {date}'**
  String availableUntil(String date);

  /// No description provided for @downloadExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت صلاحية التحميل، اتصل بالإنترنت لتجديده'**
  String get downloadExpired;

  /// No description provided for @openFile.
  ///
  /// In ar, this message translates to:
  /// **'فتح الملف'**
  String get openFile;

  /// No description provided for @fileOpensExternally.
  ///
  /// In ar, this message translates to:
  /// **'يُفتح هذا الملف بتطبيق خارجي على جهازك'**
  String get fileOpensExternally;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @changePassword.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور الجديدة'**
  String get confirmNewPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير كلمة المرور بنجاح'**
  String get passwordChanged;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات'**
  String get noNotifications;

  /// No description provided for @markAllRead.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الكل كمقروء'**
  String get markAllRead;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن درس...'**
  String get searchHint;

  /// No description provided for @searchMinChars.
  ///
  /// In ar, this message translates to:
  /// **'اكتب حرفين على الأقل'**
  String get searchMinChars;

  /// No description provided for @searchNoResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get searchNoResults;

  /// No description provided for @searchSubjects.
  ///
  /// In ar, this message translates to:
  /// **'المواد'**
  String get searchSubjects;

  /// No description provided for @searchTeachers.
  ///
  /// In ar, this message translates to:
  /// **'المدرسين'**
  String get searchTeachers;

  /// No description provided for @searchLessons.
  ///
  /// In ar, this message translates to:
  /// **'الدروس'**
  String get searchLessons;

  /// No description provided for @searchSessions.
  ///
  /// In ar, this message translates to:
  /// **'الجلسات'**
  String get searchSessions;

  /// No description provided for @searchVideos.
  ///
  /// In ar, this message translates to:
  /// **'الفيديوهات'**
  String get searchVideos;

  /// No description provided for @play.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف مؤقت'**
  String get pause;

  /// No description provided for @rewind10.
  ///
  /// In ar, this message translates to:
  /// **'رجوع 10 ثوانٍ'**
  String get rewind10;

  /// No description provided for @forward10.
  ///
  /// In ar, this message translates to:
  /// **'تقديم 10 ثوانٍ'**
  String get forward10;

  /// No description provided for @fullscreen.
  ///
  /// In ar, this message translates to:
  /// **'ملء الشاشة'**
  String get fullscreen;

  /// No description provided for @exitFullscreen.
  ///
  /// In ar, this message translates to:
  /// **'الخروج من ملء الشاشة'**
  String get exitFullscreen;

  /// No description provided for @deleteDownloadConfirm.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف هذا الفيديو من جهازك. يمكنك تحميله مجدداً لاحقاً.'**
  String get deleteDownloadConfirm;

  /// No description provided for @appVersion.
  ///
  /// In ar, this message translates to:
  /// **'الإصدار {version}'**
  String appVersion(String version);

  /// No description provided for @passwordChangeNote.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تسجيل الخروج من أي جلسة أخرى لحسابك.'**
  String get passwordChangeNote;

  /// No description provided for @markRead.
  ///
  /// In ar, this message translates to:
  /// **'تحديد كمقروء'**
  String get markRead;

  /// No description provided for @loadMore.
  ///
  /// In ar, this message translates to:
  /// **'تحميل المزيد'**
  String get loadMore;

  /// No description provided for @fileTooLargeToPreview.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن عرض هذا الملف داخل التطبيق'**
  String get fileTooLargeToPreview;

  /// No description provided for @noAppToOpenFile.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد تطبيق على جهازك يفتح هذا النوع من الملفات'**
  String get noAppToOpenFile;

  /// No description provided for @downloadingFile.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل الملف...'**
  String get downloadingFile;

  /// No description provided for @screenshotDetected.
  ///
  /// In ar, this message translates to:
  /// **'تم رصد لقطة شاشة. المحتوى محمي ومرتبط بحسابك.'**
  String get screenshotDetected;

  /// No description provided for @noVideos.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فيديوهات بعد'**
  String get noVideos;

  /// No description provided for @noFiles.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد ملفات'**
  String get noFiles;

  /// No description provided for @downloadedOnDevice.
  ///
  /// In ar, this message translates to:
  /// **'على الجهاز'**
  String get downloadedOnDevice;

  /// No description provided for @offlineTitle.
  ///
  /// In ar, this message translates to:
  /// **'أنت غير متصل بالإنترنت'**
  String get offlineTitle;

  /// No description provided for @offlineBody.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك مشاهدة الفيديوهات المحمّلة على جهازك'**
  String get offlineBody;

  /// No description provided for @navHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// No description provided for @navAccount.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get navAccount;

  /// No description provided for @homeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر المادة التي تريد دراستها'**
  String get homeSubtitle;

  /// No description provided for @mySubjects.
  ///
  /// In ar, this message translates to:
  /// **'موادي'**
  String get mySubjects;

  /// No description provided for @otherSubjects.
  ///
  /// In ar, this message translates to:
  /// **'مواد أخرى'**
  String get otherSubjects;

  /// No description provided for @otherSubjectsHint.
  ///
  /// In ar, this message translates to:
  /// **'هذه المواد مقفلة حالياً، تواصل مع إدارة المعهد لفتحها'**
  String get otherSubjectsHint;

  /// No description provided for @noSubjectsTitle.
  ///
  /// In ar, this message translates to:
  /// **'حسابك جاهز! لا توجد مواد مفتوحة لك بعد'**
  String get noSubjectsTitle;

  /// No description provided for @noSubjectsBody.
  ///
  /// In ar, this message translates to:
  /// **'عندما تفتح إدارة المعهد المواد لحسابك ستظهر هنا مباشرة.'**
  String get noSubjectsBody;

  /// No description provided for @contactInstitute.
  ///
  /// In ar, this message translates to:
  /// **'للتواصل مع المعهد: {phone}'**
  String contactInstitute(String phone);

  /// No description provided for @lockedHint.
  ///
  /// In ar, this message translates to:
  /// **'مقفل — تواصل مع إدارة المعهد لفتحه'**
  String get lockedHint;

  /// No description provided for @hintChooseTeacher.
  ///
  /// In ar, this message translates to:
  /// **'اختر المدرس لمشاهدة دروسه'**
  String get hintChooseTeacher;

  /// No description provided for @hintChooseLesson.
  ///
  /// In ar, this message translates to:
  /// **'اختر الدرس'**
  String get hintChooseLesson;

  /// No description provided for @hintChooseSession.
  ///
  /// In ar, this message translates to:
  /// **'اختر الجلسة لمشاهدة فيديوهاتها وملفاتها'**
  String get hintChooseSession;

  /// No description provided for @hintVideos.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الفيديو لمشاهدته، أو على «تحميل» لمشاهدته لاحقاً بدون إنترنت'**
  String get hintVideos;

  /// No description provided for @hintFiles.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الملف لفتحه'**
  String get hintFiles;

  /// No description provided for @download.
  ///
  /// In ar, this message translates to:
  /// **'تحميل'**
  String get download;

  /// No description provided for @downloadedShort.
  ///
  /// In ar, this message translates to:
  /// **'محمّل'**
  String get downloadedShort;

  /// No description provided for @retryShort.
  ///
  /// In ar, this message translates to:
  /// **'إعادة'**
  String get retryShort;

  /// No description provided for @createAccountButton.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get createAccountButton;

  /// No description provided for @yourGrade.
  ///
  /// In ar, this message translates to:
  /// **'صفّك الدراسي'**
  String get yourGrade;

  /// No description provided for @chooseGrade.
  ///
  /// In ar, this message translates to:
  /// **'اختر صفّك'**
  String get chooseGrade;

  /// No description provided for @gradesUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل الصفوف'**
  String get gradesUnavailable;

  /// No description provided for @playbackSpeed.
  ///
  /// In ar, this message translates to:
  /// **'سرعة التشغيل'**
  String get playbackSpeed;

  /// No description provided for @findSubject.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم المادة'**
  String get findSubject;

  /// No description provided for @findLesson.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم الدرس'**
  String get findLesson;

  /// No description provided for @findSession.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم الجلسة'**
  String get findSession;

  /// No description provided for @lessonNumber.
  ///
  /// In ar, this message translates to:
  /// **'الدرس {number}'**
  String lessonNumber(int number);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
