import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'transfer.dart';

/// The last answer of each student screen request, kept on the phone (app-private storage).
class ResponseCacheStore {
  ResponseCacheStore({Future<Directory> Function()? baseDirectory})
    : _baseDirectory = baseDirectory ?? getApplicationSupportDirectory;

  final Future<Directory> Function() _baseDirectory;

  /// A short file name for any key (a long search text would exceed the file-name limit); the
  /// key itself is stored inside and checked on read.
  Future<File> _file(String key) async {
    var hash = 0xcbf29ce484222325; // FNV-1a, 64 bit
    for (final byte in utf8.encode(key)) {
      hash = (hash ^ byte) * 0x100000001b3;
    }
    final base = await _baseDirectory();
    return File('${base.path}/http_cache/${hash.toUnsigned(64).toRadixString(16)}.json');
  }

  Future<Object?> read(String key) async {
    try {
      final file = await _file(key);
      if (!await file.exists()) return null;
      final saved = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return saved['key'] == key ? saved['data'] : null;
    } on Object {
      return null;
    }
  }

  Future<void> write(String key, Object? data) async {
    try {
      final file = await _file(key);
      await file.parent.create(recursive: true);
      // Written next to the target, then renamed: a crash never leaves half a file.
      final partial = File('${file.path}.part');
      await partial.writeAsString(jsonEncode({'key': key, 'savedAt': DateTime.now().toIso8601String(), 'data': data}));
      await partial.rename(file.path);
    } on Object {
      // A full disk or a missing plugin (tests) only means no offline copy.
    }
  }

  /// Signing out (or into another account) forgets everything.
  Future<void> clear() async {
    try {
      final dir = Directory('${(await _baseDirectory()).path}/http_cache');
      if (await dir.exists()) await dir.delete(recursive: true);
    } on Object {
      // Nothing to clear.
    }
  }
}

/// Set while the app runs without network (started offline): saved answers are used right away
/// instead of waiting for the network to fail first. Cleared as soon as the server answers again.
class OfflineMode {
  bool active = false;
}

/// Offline mode: every successful answer of a student screen (home, subjects, teachers, lessons,
/// sessions, profile, notifications...) is kept, and when the network or the server cannot be
/// reached the last copy is returned — the app opens exactly as it was, without anything new,
/// until the connection is back. Online, the server always answers.
///
/// Never cached: signed media links (playlists, keys, files) and offline licenses.
class OfflineCacheInterceptor extends Interceptor {
  OfflineCacheInterceptor(this.store, {OfflineMode? mode}) : mode = mode ?? OfflineMode();

  final ResponseCacheStore store;
  final OfflineMode mode;

  /// Marks a response that came from the phone instead of the server.
  static const fromCacheKey = 'fromOfflineCache';

  // The account itself is kept by the auth repository.
  static const _cached = ['/student/', '/public/config'];
  static const _neverCached = ['/student/offline-licenses'];

  static bool cacheable(RequestOptions options) {
    if (options.method != 'GET') return false;
    final path = options.path;
    if (path.startsWith('http')) return false; // absolute, signed media URLs
    return _cached.any(path.startsWith) && !_neverCached.any(path.startsWith);
  }

  static String keyOf(RequestOptions options) {
    final query = options.queryParameters.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    return [options.path, for (final entry in query) '${entry.key}=${entry.value}'].join('&');
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (mode.active && cacheable(options)) {
      final data = await store.read(keyOf(options));
      if (data != null) {
        handler.resolve(_saved(options, data));
        return;
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (cacheable(response.requestOptions) && response.statusCode == 200) {
      await store.write(keyOf(response.requestOptions), response.data);
    }
    handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (cacheable(err.requestOptions) && isRetryable(err)) {
      final data = await store.read(keyOf(err.requestOptions));
      if (data != null) {
        handler.resolve(_saved(err.requestOptions, data));
        return;
      }
    }
    handler.next(err);
  }

  static Response<dynamic> _saved(RequestOptions options, Object data) =>
      Response<dynamic>(requestOptions: options, statusCode: 200, data: data, extra: {fromCacheKey: true});
}
