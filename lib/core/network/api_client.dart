import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api_error_mapper.dart';
import 'transfer.dart';

typedef JsonParser<T> = T Function(Object? data);

/// Thin, typed wrapper over Dio for the backend's `{ success, data }` envelope.
/// Every failure surfaces as an `AppFailure` (never a raw DioException), so repositories and
/// the domain layer stay independent of the HTTP library.
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<T> get<T>(String path, JsonParser<T> parse, {Map<String, Object?>? query}) =>
      _send(() => _dio.get<Object?>(path, queryParameters: query), parse);

  Future<T> post<T>(String path, JsonParser<T> parse, {Object? body}) =>
      _send(() => _dio.post<Object?>(path, data: body), parse);

  Future<T> put<T>(String path, JsonParser<T> parse, {Object? body}) =>
      _send(() => _dio.put<Object?>(path, data: body), parse);

  Future<T> delete<T>(String path, JsonParser<T> parse) => _send(() => _dio.delete<Object?>(path), parse);

  /// Raw bytes from an absolute, pre-signed media URL (file downloads, HLS keys).
  Future<Uint8List> bytes(String url, {void Function(int received, int total)? onProgress}) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: onProgress,
      );
      return Uint8List.fromList(response.data ?? const []);
    } on DioException catch (error) {
      throw toFailure(error);
    }
  }

  /// A signed media URL downloaded over several connections at once (see [ParallelDownloader]).
  Future<Uint8List> parallelBytes(
    String url, {
    void Function(TransferProgress progress)? onProgress,
    Future<String> Function()? refreshUrl,
  }) async {
    try {
      return await ParallelDownloader(_dio).download(url, onProgress: onProgress, refreshUrl: refreshUrl);
    } on DioException catch (error) {
      throw toFailure(error);
    }
  }

  /// Text from an absolute, pre-signed media URL (HLS playlists).
  Future<String> text(String url) async {
    try {
      final response = await _dio.get<String>(url, options: Options(responseType: ResponseType.plain));
      return response.data ?? '';
    } on DioException catch (error) {
      throw toFailure(error);
    }
  }

  Future<T> _send<T>(Future<Response<Object?>> Function() request, JsonParser<T> parse) async {
    try {
      final response = await request();
      final body = response.data;
      final data = body is Map<String, Object?> ? body['data'] : null;
      return parse(data);
    } on DioException catch (error) {
      throw toFailure(error);
    }
  }
}

/// Helpers for parsing envelope payloads.
Map<String, Object?> asMap(Object? data) => (data as Map).cast<String, Object?>();

List<Map<String, Object?>> asMapList(Object? data) =>
    (data as List).map((item) => (item as Map).cast<String, Object?>()).toList();
