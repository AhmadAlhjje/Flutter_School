import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Download progress: the done fraction (0..1) and the bytes received so far.
class TransferProgress {
  const TransferProgress(this.fraction, this.bytes);

  final double fraction;
  final int bytes;
}

/// Runs [task] for every item with at most [workers] running at the same time.
///
/// Several connections at once are much faster than one on long, lossy routes (a single TCP
/// connection is held back by latency and packet loss). The first failure stops the pool.
Future<void> runPool<T>(List<T> items, int workers, Future<void> Function(T item) task) async {
  var next = 0;
  Object? failure;
  StackTrace? failureTrace;
  Future<void> worker() async {
    while (failure == null && next < items.length) {
      final item = items[next++];
      try {
        await task(item);
      } catch (error, trace) {
        failure ??= error;
        failureTrace ??= trace;
      }
    }
  }

  await Future.wait([for (var i = 0; i < min(workers, items.length); i++) worker()]);
  if (failure != null) Error.throwWithStackTrace(failure!, failureTrace!);
}

/// Network hiccups (timeouts, dropped connections, 5xx) are retried with a growing pause;
/// anything else (403, 404, …) fails at once.
bool isRetryable(Object error) {
  if (error is! DioException) return false;
  return switch (error.type) {
    DioExceptionType.connectionError ||
    DioExceptionType.connectionTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.unknown => true,
    DioExceptionType.badResponse => (error.response?.statusCode ?? 0) >= 500,
    _ => false,
  };
}

Future<T> withRetry<T>(
  Future<T> Function() action, {
  int attempts = 4,
  Duration delay = const Duration(seconds: 1),
}) async {
  for (var attempt = 1; ; attempt++) {
    try {
      return await action();
    } catch (error) {
      if (attempt >= attempts || !isRetryable(error)) rethrow;
      await Future<void>.delayed(delay * attempt);
    }
  }
}

/// Downloads [url] into memory over several connections at once (HTTP `Range` requests).
///
/// The first request asks for the first part and learns the total size; the other parts then
/// come in parallel. A server that ignores `Range` simply sends everything in the first answer.
/// [refreshUrl] is called when a signed URL expires mid-download (HTTP 403) to get a fresh one.
class ParallelDownloader {
  ParallelDownloader(
    this.dio, {
    this.connections = 4,
    this.partBytes = 1024 * 1024,
    this.retryDelay = const Duration(seconds: 1),
  });

  final Dio dio;
  final int connections;
  final int partBytes;
  final Duration retryDelay;

  Future<Uint8List> download(
    String url, {
    void Function(TransferProgress progress)? onProgress,
    Future<String> Function()? refreshUrl,
  }) async {
    var currentUrl = url;
    Future<String>? refreshing;

    Future<Response<List<int>>> getPart(int start, int end, void Function(int received) onReceived) async {
      for (var refreshed = false; ; refreshed = true) {
        try {
          return await withRetry(
            () => dio.get<List<int>>(
              currentUrl,
              options: Options(responseType: ResponseType.bytes, headers: {'Range': 'bytes=$start-$end'}),
              onReceiveProgress: (received, _) => onReceived(received),
            ),
            delay: retryDelay,
          );
        } on DioException catch (error) {
          // The signed URL expired while the other parts were downloading: renew it once.
          if (refreshed || refreshUrl == null || error.response?.statusCode != 403) rethrow;
          currentUrl = await (refreshing ??= refreshUrl().whenComplete(() => refreshing = null));
        }
      }
    }

    final first = await getPart(0, partBytes - 1, (received) => onProgress?.call(TransferProgress(0, received)));
    final firstBytes = first.data ?? const <int>[];
    final total = _totalSize(first);
    if (first.statusCode != 206 || total == null || total <= firstBytes.length) {
      onProgress?.call(TransferProgress(1, firstBytes.length));
      return Uint8List.fromList(firstBytes);
    }

    final result = Uint8List(total)..setRange(0, firstBytes.length, firstBytes);
    final parts = <(int, int)>[
      for (var start = firstBytes.length; start < total; start += partBytes) (start, min(start + partBytes, total) - 1),
    ];
    final inFlight = <int, int>{};
    var done = firstBytes.length;
    void report() {
      final bytes = done + inFlight.values.fold<int>(0, (sum, value) => sum + value);
      onProgress?.call(TransferProgress(bytes / total, bytes));
    }

    await runPool(parts, connections, (part) async {
      final (start, end) = part;
      final response = await getPart(start, end, (received) {
        inFlight[start] = received;
        report();
      });
      final bytes = response.data ?? const <int>[];
      if (response.statusCode != 206 || bytes.length != end - start + 1) {
        throw DioException(requestOptions: response.requestOptions, message: 'Incomplete part $start-$end');
      }
      result.setRange(start, end + 1, bytes);
      inFlight.remove(start);
      done += bytes.length;
      report();
    });
    return result;
  }

  /// Total size from `Content-Range: bytes 0-1048575/52428800`.
  static int? _totalSize(Response<Object?> response) {
    final range = response.headers.value('content-range');
    final total = range?.split('/').last;
    return total == null ? null : int.tryParse(total);
  }
}
