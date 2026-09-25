import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/network/transfer.dart';

import '../support/fake_http.dart';

/// A file server that honors `Range` like the backend (Express sendFile), with switches for the
/// cases the downloader must survive.
class _RangeServer {
  _RangeServer(this.content);

  final Uint8List content;
  bool ignoreRanges = false;
  String validToken = 'first';
  int dropNext = 0;
  final ranges = <String>[];

  ResponseBody handle(RequestOptions options) {
    if (options.uri.queryParameters['token'] != validToken) return apiError('MEDIA_TOKEN_INVALID', 403);
    if (dropNext > 0) {
      dropNext--;
      throw DioException.connectionError(requestOptions: options, reason: 'connection reset');
    }
    final range = options.headers['Range'] as String?;
    if (ignoreRanges || range == null) return bytesResponse(content);
    ranges.add(range);
    final match = RegExp(r'bytes=(\d+)-(\d+)').firstMatch(range)!;
    final start = int.parse(match[1]!);
    final end = int.parse(match[2]!).clamp(0, content.length - 1);
    final part = content.sublist(start, end + 1);
    return ResponseBody.fromBytes(
      part,
      206,
      headers: {
        Headers.contentLengthHeader: ['${part.length}'],
        'content-range': ['bytes $start-$end/${content.length}'],
      },
    );
  }
}

void main() {
  final content = Uint8List.fromList(List<int>.generate(10 * 1000 + 7, (i) => (i * 31) % 256));

  ParallelDownloader downloaderFor(_RangeServer server) => ParallelDownloader(
    Dio()..httpClientAdapter = FakeHttpAdapter(server.handle),
    partBytes: 1000,
    retryDelay: Duration.zero,
  );

  test('downloads a file in parallel parts and reassembles it exactly', () async {
    final server = _RangeServer(content);
    final progress = <double>[];
    final bytes = await downloaderFor(server)
        .download('http://api.test/f?token=first', onProgress: (p) => progress.add(p.fraction));
    expect(bytes, content);
    expect(server.ranges.length, 11, reason: 'first part + 10 more in parallel');
    expect(progress.last, 1.0);
  });

  test('falls back to one request when the server ignores Range', () async {
    final server = _RangeServer(content)..ignoreRanges = true;
    expect(await downloaderFor(server).download('http://api.test/f?token=first'), content);
  });

  test('retries dropped connections and renews an expired link', () async {
    final server = _RangeServer(content)..dropNext = 2;
    var renewals = 0;
    final bytes = await downloaderFor(server).download(
      'http://api.test/f?token=first',
      onProgress: (p) {
        // The link expires while the parts are downloading.
        if (p.fraction > 0.3) server.validToken = 'second';
      },
      refreshUrl: () async {
        renewals++;
        return 'http://api.test/f?token=second';
      },
    );
    expect(bytes, content);
    expect(renewals, greaterThanOrEqualTo(1));
  });

  test('a real error (not a network hiccup) fails at once', () async {
    final server = _RangeServer(content)..validToken = 'other';
    await expectLater(
      downloaderFor(server).download('http://api.test/f?token=first'),
      throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 403)),
    );
  });
}
