// Runs the app's real data layer (repositories, AuthInterceptor, offline store) against a
// running backend. Skipped unless LIVE_API_CONFIG points to the JSON written by
// `npm run app:live-setup` in the backend project (see its docs/development.md).
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/network/api_client.dart';
import 'package:student_app/core/network/auth_interceptor.dart';
import 'package:student_app/core/network/session_events.dart';
import 'package:student_app/core/security/device_identity.dart';
import 'package:student_app/core/storage/secure_store.dart';
import 'package:student_app/core/storage/token_store.dart';
import 'package:student_app/features/auth/data/auth_repository_impl.dart';
import 'package:student_app/features/auth/domain/entities/student_account.dart';
import 'package:student_app/features/files/data/files_repository_impl.dart';
import 'package:student_app/features/files/domain/file_entities.dart';
import 'package:student_app/features/grades/data/grades_repository_impl.dart';
import 'package:student_app/features/home/data/home_repository_impl.dart';
import 'package:student_app/features/notifications/data/notifications_repository_impl.dart';
import 'package:student_app/features/profile/data/profile_repository_impl.dart';
import 'package:student_app/features/search/data/search_repository_impl.dart';
import 'package:student_app/features/sessions/data/sessions_repository_impl.dart';
import 'package:student_app/features/subjects/data/subjects_repository_impl.dart';
import 'package:student_app/features/teachers/data/teachers_repository_impl.dart';
import 'package:student_app/features/topics/data/topics_repository_impl.dart';
import 'package:student_app/features/videos/data/offline/offline_downloads_impl.dart';
import 'package:student_app/features/videos/data/videos_repository_impl.dart';

/// Real identifier logic; fixed descriptor because device_info/package_info need a device.
class _TestDevice extends DeviceIdentity {
  _TestDevice(super.secure);

  @override
  Future<DeviceDescriptor> describe() async =>
      DeviceDescriptor(identifier: await identifier(), platform: 'ANDROID', model: 'live-test', appVersion: '1.0.0');
}

Future<List<int>> _getBytes(Uri uri) async {
  final client = HttpClient();
  try {
    final response = await (await client.getUrl(uri)).close();
    expect(response.statusCode, 200, reason: uri.toString());
    return await response.fold<List<int>>([], (all, chunk) => all..addAll(chunk));
  } finally {
    client.close(force: true);
  }
}

void main() {
  final configPath = Platform.environment['LIVE_API_CONFIG'];

  group('live API', skip: configPath == null ? 'LIVE_API_CONFIG not set' : false, () {
    late Map<String, dynamic> config;
    late InMemorySecureStore secure;
    late ApiClient api;
    late Dio dio;
    late AuthRepositoryImpl auth;
    late StudentAccount account;
    final published = <SessionEndReason>[];

    setUpAll(() async {
      config = jsonDecode(File(configPath!).readAsStringSync()) as Map<String, dynamic>;
      // One stable device per test student, so the suite can be re-run with the same config.
      secure = InMemorySecureStore()..values['device.identifier'] = 'device-live-${config['phone']}';
      final tokens = TokenStore(secure);
      final device = _TestDevice(secure);
      final events = SessionEvents()..stream.listen(published.add);
      final options = BaseOptions(
        baseUrl: '${config['apiBaseUrl']}/api/v1',
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      );
      dio = Dio(options);
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          refreshDio: Dio(options),
          tokens: tokens,
          device: device,
          events: events,
          language: () => 'ar',
        ),
      );
      api = ApiClient(dio);
      auth = AuthRepositoryImpl(api: api, tokens: tokens, device: device, secure: secure);
      account = await auth.login(phone: config['phone'] as String, password: config['password'] as String);
    });

    test('signs in and binds the device', () {
      expect(account.phone, config['phone']);
    });

    test('the same account is refused on a second device', () async {
      final otherStore = InMemorySecureStore();
      final other = AuthRepositoryImpl(
        api: ApiClient(Dio(BaseOptions(baseUrl: '${config['apiBaseUrl']}/api/v1'))),
        tokens: TokenStore(otherStore),
        device: _TestDevice(otherStore),
        secure: otherStore,
      );
      await expectLater(
        other.login(phone: config['phone'] as String, password: config['password'] as String),
        throwsA(isA<AppFailure>().having((f) => f.kind, 'kind', FailureKind.deviceMismatch)),
      );
    });

    test('catalog screens parse the real responses and show the opened content', () async {
      final home = await HomeRepositoryImpl(api).home();
      expect(home.subjects.firstWhere((s) => s.id == config['subjectId']).locked, isFalse);

      final grades = await GradesRepositoryImpl(api).grades();
      expect(grades.map((g) => g.id), contains(config['gradeId']));
      final grade = await GradesRepositoryImpl(api).gradeSubjects(config['gradeId'] as String);
      expect(grade.subjects.firstWhere((s) => s.id == config['subjectId']).locked, isFalse);

      final subject = await SubjectsRepositoryImpl(api).subject(config['subjectId'] as String);
      expect(subject.locked, isFalse);
      expect(subject.teachers.firstWhere((t) => t.subjectTeacherId == config['subjectTeacherId']).locked, isFalse);

      final space = await TeachersRepositoryImpl(api).teacherSpace(config['subjectTeacherId'] as String);
      expect(space.topics.map((t) => t.id), contains(config['topicId']));

      final topic = await TopicsRepositoryImpl(api).topic(config['topicId'] as String);
      expect(topic.sessions.map((s) => s.id), contains(config['sessionId']));

      final session = await SessionsRepositoryImpl(api).session(config['sessionId'] as String);
      expect(session.videos.map((v) => v.id), contains(config['videoId']));
      expect(session.files.map((f) => f.id), contains(config['fileId']));
      expect(session.videos.firstWhere((v) => v.id == config['videoId']).durationSeconds, greaterThan(0));
    });

    test('playback grant opens the signed HLS playlist', () async {
      final grant = await VideosRepositoryImpl(api).requestPlayback(config['videoId'] as String);
      expect(grant.expiresAt.isAfter(DateTime.now()), isTrue);
      final master = await api.text(grant.manifestUrl.toString());
      expect(master, startsWith('#EXTM3U'));
      expect(master, contains('token='));
      if (grant.watermarkText != null) expect(grant.watermarkText, contains(config['phone']));
    });

    test('file access returns a short-lived URL and the PDF bytes', () async {
      final files = FilesRepositoryImpl(api);
      final grant = await files.requestAccess(config['fileId'] as String);
      expect(grant.kind, FileKind.pdf);
      final bytes = await files.download(grant);
      expect(bytes.length, config['pdfSize']);
      expect(ascii.decode(bytes.take(5).toList()), '%PDF-');
    });

    test('profile, notifications and search', () async {
      final profile = await ProfileRepositoryImpl(api).profile();
      expect(profile.phone, config['phone']);
      expect(profile.deviceModel, 'live-test');
      expect(profile.openTeachersCount, greaterThanOrEqualTo(1));

      final notifications = NotificationsRepositoryImpl(api);
      final inbox = await notifications.inbox();
      expect(inbox.page, 1);
      expect(await notifications.unreadCount(), greaterThanOrEqualTo(0));

      final session = await SessionsRepositoryImpl(api).session(config['sessionId'] as String);
      final title = session.videos.first.title;
      final results = await SearchRepositoryImpl(api).search(title.substring(0, title.length.clamp(2, 6)));
      expect(results.isEmpty, isFalse);
    });

    test('offline: download, play through loopback, keep on sync, revoke on delete', () async {
      final base = await Directory.systemTemp.createTemp('live_offline');
      final downloads = OfflineDownloadsImpl(
        api: api,
        dio: dio,
        secure: secure,
        accountId: account.id,
        baseDirectory: () async => base,
      );
      try {
        final video = await downloads.download(config['videoId'] as String);
        expect(video.sizeBytes, greaterThan(0));

        final uri = await downloads.openStream(video.licenseId);
        final playlist = utf8.decode(await _getBytes(uri));
        expect(playlist, contains('URI="key"'));
        expect(playlist, isNot(contains('token=')));
        expect(await _getBytes(uri.resolve('key')), hasLength(16));
        final firstSegment = RegExp(r'seg_\d+\.ts').firstMatch(playlist)!.group(0)!;
        expect((await _getBytes(uri.resolve(firstSegment))).length, greaterThan(0));
        await downloads.closeStream();

        await downloads.sync();
        expect((await downloads.list()).single.licenseId, video.licenseId);

        await downloads.delete(video.licenseId);
        expect(await downloads.list(), isEmpty);
      } finally {
        await downloads.closeStream();
        await base.delete(recursive: true);
      }
    });

    test('restores the session with the rotated refresh token', () async {
      final restored = await auth.restoreSession();
      expect(restored, isNotNull);
      expect(restored!.offline, isFalse);
      expect(restored.account.id, account.id);
      expect(published, isEmpty);
    });

    tearDownAll(() async {
      await auth.logout();
    });
  });
}
