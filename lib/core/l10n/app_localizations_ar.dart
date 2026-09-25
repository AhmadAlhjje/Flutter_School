// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'المعهد التعليمي';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get close => 'إغلاق';

  @override
  String get confirm => 'تأكيد';

  @override
  String get errorLoading => 'حدث خطأ أثناء تحميل البيانات';

  @override
  String get errorNetwork => 'تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت';

  @override
  String get errorGeneric => 'حدث خطأ ما، حاول مرة أخرى';

  @override
  String get errorInvalidCredentials => 'رقم الهاتف أو كلمة المرور غير صحيحة';

  @override
  String get errorSessionExpired => 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً';

  @override
  String get errorAccessDenied => 'هذا المحتوى مقفل';

  @override
  String get errorNotFound => 'المحتوى غير موجود أو لم يعد متاحاً';

  @override
  String get errorVideoNotReady => 'الفيديو غير جاهز بعد';

  @override
  String get errorRateLimited => 'محاولات كثيرة، يرجى الانتظار قليلاً';

  @override
  String get errorPhoneTaken => 'رقم الهاتف مستخدم مسبقاً';

  @override
  String get errorRegistrationDisabled =>
      'التسجيل غير متاح حالياً، تواصل مع إدارة المعهد';

  @override
  String get errorWeakPassword =>
      'كلمة المرور ضعيفة: 8 أحرف على الأقل وتحتوي على حروف وأرقام';

  @override
  String get errorInvalidCurrentPassword => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get errorOfflineDisabled => 'التحميل للمشاهدة دون إنترنت غير متاح';

  @override
  String get errorValidation => 'البيانات المدخلة غير صحيحة';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get invalidPhone => 'رقم الهاتف غير صالح';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get passwordHint => '8 أحرف على الأقل، وتحتوي على حروف وأرقام';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String loginSubtitle(String institute) {
    return 'أهلاً بك في $institute';
  }

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'دخول';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get registerTitle => 'إنشاء حساب جديد';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get register => 'تسجيل';

  @override
  String get haveAccount => 'لديك حساب؟';

  @override
  String get deviceNotice => 'سيتم ربط حسابك بهذا الجهاز عند أول تسجيل دخول.';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirm => 'هل تريد تسجيل الخروج؟';

  @override
  String get deviceErrorTitle => 'الحساب مرتبط بجهاز آخر';

  @override
  String get deviceErrorBody =>
      'لا يمكن استخدام هذا الحساب إلا على الجهاز المرتبط به. لتغيير الجهاز يرجى التواصل مع إدارة المعهد.';

  @override
  String get accountDisabledTitle => 'الحساب معطّل';

  @override
  String get accountDisabledBody =>
      'تم تعطيل حسابك. يرجى التواصل مع إدارة المعهد.';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String helloName(String name) {
    return 'مرحباً $name 👋';
  }

  @override
  String get yourSubjects => 'موادك';

  @override
  String get browseGrades => 'تصفح الصفوف';

  @override
  String get noSubjects => 'لا توجد مواد بعد';

  @override
  String get grades => 'الصفوف';

  @override
  String get noGrades => 'لا توجد صفوف';

  @override
  String subjectsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مادة',
      many: '$count مادة',
      few: '$count مواد',
      two: 'مادتان',
      one: 'مادة واحدة',
      zero: 'لا مواد',
    );
    return '$_temp0';
  }

  @override
  String teachersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مدرس',
      many: '$count مدرساً',
      few: '$count مدرسين',
      two: 'مدرسان',
      one: 'مدرس واحد',
      zero: 'لا مدرسين',
    );
    return '$_temp0';
  }

  @override
  String topicsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count درس',
      many: '$count درساً',
      few: '$count دروس',
      two: 'درسان',
      one: 'درس واحد',
      zero: 'لا دروس',
    );
    return '$_temp0';
  }

  @override
  String sessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count جلسة',
      many: '$count جلسة',
      few: '$count جلسات',
      two: 'جلستان',
      one: 'جلسة واحدة',
      zero: 'لا جلسات',
    );
    return '$_temp0';
  }

  @override
  String videosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count فيديو',
      many: '$count فيديو',
      few: '$count فيديوهات',
      two: 'فيديوهان',
      one: 'فيديو واحد',
      zero: 'لا فيديوهات',
    );
    return '$_temp0';
  }

  @override
  String filesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملف',
      many: '$count ملفاً',
      few: '$count ملفات',
      two: 'ملفان',
      one: 'ملف واحد',
      zero: 'لا ملفات',
    );
    return '$_temp0';
  }

  @override
  String get locked => 'مقفل';

  @override
  String get open => 'مفتوح';

  @override
  String get lockedTitle => 'المحتوى مقفل';

  @override
  String get lockedBody =>
      'هذا المحتوى غير متاح لك حالياً. تواصل مع إدارة المعهد لفتحه.';

  @override
  String get teachers => 'المدرسون';

  @override
  String get noTeachers => 'لا يوجد مدرسون في هذه المادة';

  @override
  String get subjectFiles => 'ملفات المادة';

  @override
  String teacherTitle(String name) {
    return 'الأستاذ $name';
  }

  @override
  String get lessons => 'الدروس';

  @override
  String get noLessons => 'لا توجد دروس بعد';

  @override
  String get teacherFiles => 'ملفات المدرس';

  @override
  String get sessions => 'الجلسات';

  @override
  String get noSessions => 'لا توجد جلسات بعد';

  @override
  String get topicFiles => 'ملفات الدرس';

  @override
  String get videos => 'الفيديوهات';

  @override
  String get files => 'الملفات';

  @override
  String get noSessionContent => 'لا يوجد محتوى في هذه الجلسة بعد';

  @override
  String get playerError => 'تعذر تشغيل الفيديو';

  @override
  String get captureBlocked =>
      'لا يمكن عرض الفيديو أثناء تسجيل الشاشة أو مشاركتها';

  @override
  String get downloadOffline => 'تحميل للمشاهدة دون إنترنت';

  @override
  String downloadingPercent(int percent) {
    return 'جاري التحميل $percent%';
  }

  @override
  String get downloaded => 'تم التحميل';

  @override
  String get downloadFailed => 'فشل التحميل';

  @override
  String get deleteDownload => 'حذف التحميل';

  @override
  String get downloads => 'التحميلات';

  @override
  String get noDownloads => 'لا توجد تحميلات';

  @override
  String availableUntil(String date) {
    return 'متاح حتى $date';
  }

  @override
  String get downloadExpired => 'انتهت صلاحية التحميل، اتصل بالإنترنت لتجديده';

  @override
  String get openFile => 'فتح الملف';

  @override
  String get fileOpensExternally => 'يُفتح هذا الملف بتطبيق خارجي على جهازك';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get passwordChanged => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get linkedDevice => 'الجهاز المرتبط';

  @override
  String linkedSince(String date) {
    return 'مرتبط منذ $date';
  }

  @override
  String get openedContent => 'المحتوى المفتوح';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get markAllRead => 'تحديد الكل كمقروء';

  @override
  String get search => 'بحث';

  @override
  String get searchHint => 'ابحث عن درس...';

  @override
  String get searchMinChars => 'اكتب حرفين على الأقل';

  @override
  String get searchNoResults => 'لا توجد نتائج';

  @override
  String get searchSubjects => 'المواد';

  @override
  String get searchTeachers => 'المدرسون';

  @override
  String get searchLessons => 'الدروس';

  @override
  String get searchSessions => 'الجلسات';

  @override
  String get searchVideos => 'الفيديوهات';

  @override
  String get play => 'تشغيل';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get rewind10 => 'رجوع 10 ثوانٍ';

  @override
  String get forward10 => 'تقديم 10 ثوانٍ';

  @override
  String get fullscreen => 'ملء الشاشة';

  @override
  String get exitFullscreen => 'الخروج من ملء الشاشة';

  @override
  String get deleteDownloadConfirm =>
      'سيتم حذف هذا الفيديو من جهازك. يمكنك تحميله مجدداً لاحقاً.';

  @override
  String get downloadsInProgress => 'قيد التحميل';

  @override
  String get downloadsNote =>
      'الفيديوهات المحملة مشفرة ولا تعمل إلا داخل التطبيق وعلى هذا الجهاز.';

  @override
  String get playOffline => 'تشغيل';

  @override
  String appVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get noLinkedDevice => 'لا يوجد جهاز مرتبط';

  @override
  String get passwordChangeNote => 'سيتم تسجيل الخروج من أي جلسة أخرى لحسابك.';

  @override
  String get markRead => 'تحديد كمقروء';

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String get fileTooLargeToPreview => 'لا يمكن عرض هذا الملف داخل التطبيق';

  @override
  String get noAppToOpenFile =>
      'لا يوجد تطبيق على جهازك يفتح هذا النوع من الملفات';

  @override
  String get downloadingFile => 'جاري تحميل الملف...';

  @override
  String get screenshotDetected =>
      'تم رصد لقطة شاشة. المحتوى محمي ومرتبط بحسابك.';
}
