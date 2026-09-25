import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

typedef FakeHandler = FutureOr<ResponseBody> Function(RequestOptions options);

/// A scripted HTTP transport: Dio talks to [handler] instead of the network. The real client
/// code (interceptors, parsing, error mapping) runs unchanged on top of it.
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.handler);

  final FakeHandler handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonResponse(Object? body, {int status = 200}) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

/// The backend success envelope.
ResponseBody ok(Object? data) => jsonResponse({'success': true, 'data': data, 'message': 'OK'});

/// The backend error envelope.
ResponseBody apiError(String code, int status) => jsonResponse({
  'success': false,
  'data': null,
  'message': code,
  'error': {'code': code, 'details': null},
}, status: status);

ResponseBody bytesResponse(List<int> bytes, {String contentType = 'application/octet-stream'}) =>
    ResponseBody.fromBytes(
      bytes,
      200,
      headers: {
        Headers.contentTypeHeader: [contentType],
        Headers.contentLengthHeader: ['${bytes.length}'],
      },
    );

ResponseBody textResponse(String text, {String contentType = 'application/vnd.apple.mpegurl'}) =>
    bytesResponse(utf8.encode(text), contentType: contentType);
