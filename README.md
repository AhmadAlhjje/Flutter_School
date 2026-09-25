# تطبيق الطالب (flutter_app)

تطبيق Android و iOS للطلاب: تصفح الصفوف والمواد والمدرسين والدروس والجلسات، مشاهدة الفيديو
المشفّر مع علامة مائية، فتح ملفات الدروس، التحميل للمشاهدة بدون إنترنت، الإشعارات، البحث،
الملف الشخصي. عربي افتراضياً مع الإنجليزية.

Riverpod 3 · go_router · Dio · Freezed + json_serializable · flutter_secure_storage · video_player · pdfrx.

## التشغيل على هاتف أندرويد

1. شغّل الـ backend (`npm run dev` داخل مجلد backend).
2. على الهاتف: فعّل **خيارات المطوّر** (اضغط 7 مرات على رقم الإصدار) ثم **تصحيح USB**.
3. صِل الهاتف بالكابل ووافق على رسالة "السماح بتصحيح USB".
4. داخل هذا المجلد:

```bash
flutter run
```

كل تشغيل بنسخة التطوير ينفّذ `adb reverse` تلقائياً، فيصل الهاتف إلى الـ backend على اللابتوب
عبر `http://localhost:4000` بدون أي إعداد للشبكة. المحاكي (emulator) يعمل بنفس الطريقة.
أول بناء يأخذ عدة دقائق، والمرات التالية أسرع بكثير.

دخول الطالب التجريبي: `0933333333` / `Student123` (أول هاتف يسجّل به يُربط بالحساب).

## ملف `.env`

| المتغير | المعنى |
|---|---|
| `API_BASE_URL` | عنوان الـ API. محلياً: `http://localhost:4000`. للإصدار: `https://api.your-domain.com` |

الملف يُضمَّن داخل التطبيق، لذلك يوضع فيه العنوان فقط (لا أسرار). يمكن تجاوزه عند البناء بـ
`--dart-define=API_BASE_URL=...`.

## أوامر أخرى

| الأمر | ماذا يفعل |
|---|---|
| `flutter test` | الاختبارات |
| `flutter analyze` | الفحص |
| `dart run build_runner build --delete-conflicting-outputs` | بعد تعديل كلاسات Freezed/JSON |
| `flutter gen-l10n` | بعد تعديل النصوص في `lib/core/l10n/*.arb` |
| `flutter build apk --release` | نسخة الإصدار (بعد وضع عنوان https في `.env`) |
| `flutter build appbundle --release` | لـ Google Play |

الـ NDK المستخدم محدد في `android/gradle.properties` (`edu.ndkVersion`).

## توقيع نسخة الإصدار (Android)

أنشئ `android/key.properties` (لا يُرفع إلى git):

```properties
storeFile=/absolute/path/upload-keystore.jks
storePassword=...
keyAlias=upload
keyPassword=...
```

`keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`.
بدونه تُوقَّع نسخة الإصدار بمفتاح التطوير (للتجربة فقط). معرّف التطبيق: `com.eduplatform.student_app`.

## الحماية

| الميزة | Android | iOS |
|---|---|---|
| معرّف الجهاز | `ANDROID_ID` | UUID محفوظ في Keychain |
| منع تصوير الشاشة | `FLAG_SECURE` (اللقطات والتسجيل سوداء) | إخفاء الفيديو أثناء تسجيل الشاشة + تنبيه عند اللقطة |
| التخزين الآمن | Keystore | Keychain |
| نسخ بيانات التطبيق احتياطياً | معطّل | — |

نسخة iOS تُبنى على جهاز Mac فقط (`flutter build ipa`).

## بنية المشروع

```
lib/core/            الإعدادات، الشبكة، التوجيه، التخزين الآمن، الحماية، الترجمة، الثيم
lib/shared/          عناصر واجهة مشتركة
lib/features/<x>/    domain (منطق نقي) · data (API) · presentation (الشاشات)
test/                الاختبارات (test/live يعمل على خادم حقيقي عند الطلب)
```
