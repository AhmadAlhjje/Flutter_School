import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

/// Serves one downloaded, still-encrypted HLS stream to the video player over loopback.
///
/// - Bound to 127.0.0.1 on a random port, reachable only from this device.
/// - Every path is prefixed by a random per-playback nonce; anything else is 404.
/// - The AES key is served from memory (read from the keystore by the caller) and never
///   written to disk. Segments stay encrypted at rest; the player decrypts them.
/// - Runs only while the player screen is open.
class LocalHlsServer {
  HttpServer? _server;
  String? _nonce;

  bool get isRunning => _server != null;

  Future<Uri> start({required Directory directory, required Uint8List key}) async {
    await stop();
    final random = Random.secure();
    final nonce = List.generate(16, (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server = server;
    _nonce = nonce;

    server.listen((request) async {
      final response = request.response;
      response.headers.set(HttpHeaders.cacheControlHeader, 'no-store');
      final segments = request.uri.pathSegments;
      try {
        if (request.method != 'GET' || segments.length != 2 || segments.first != _nonce) {
          response.statusCode = HttpStatus.notFound;
        } else {
          final name = segments[1];
          if (name == 'index.m3u8') {
            response.headers.contentType = ContentType('application', 'vnd.apple.mpegurl');
            response.add(await File('${directory.path}/index.m3u8').readAsBytes());
          } else if (name == 'key') {
            response.headers.contentType = ContentType.binary;
            response.add(key);
          } else if (RegExp(r'^seg_\d{5,6}\.ts$').hasMatch(name)) {
            final file = File('${directory.path}/$name');
            if (await file.exists()) {
              response.headers.contentType = ContentType('video', 'mp2t');
              response.headers.contentLength = await file.length();
              await response.addStream(file.openRead());
            } else {
              response.statusCode = HttpStatus.notFound;
            }
          } else {
            response.statusCode = HttpStatus.notFound;
          }
        }
      } catch (_) {
        response.statusCode = HttpStatus.internalServerError;
      } finally {
        await response.close();
      }
    });

    return Uri.parse('http://127.0.0.1:${server.port}/$nonce/index.m3u8');
  }

  Future<void> stop() async {
    final server = _server;
    _server = null;
    _nonce = null;
    await server?.close(force: true);
  }
}
