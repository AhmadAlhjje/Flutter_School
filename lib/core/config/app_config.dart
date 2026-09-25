import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dotenv.dart';

/// App configuration, read once at startup from the `.env` file bundled with the app
/// (`API_BASE_URL=...`). A build-time `--dart-define=API_BASE_URL=...` takes precedence.
///
/// The server: `http://163.245.221.210:6003` (Android release builds allow plain HTTP only to the
/// API host written in `.env`). Local development: `http://localhost:4000` — every debug build
/// runs `adb reverse`, so a phone connected by USB (or an emulator) reaches the backend on the laptop.
abstract final class AppConfig {
  static const _fromDefine = String.fromEnvironment('API_BASE_URL');
  static const _fallback = 'http://localhost:4000';

  static String _apiBaseUrl = _fromDefine.isNotEmpty ? _fromDefine : _fallback;

  static String get apiBaseUrl => _apiBaseUrl;

  static String get apiRoot => '${apiBaseUrl.replaceAll(RegExp(r'/+$'), '')}/api/v1';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 60);

  /// Loads `.env` from the app bundle. Missing file or key keeps the defaults.
  static Future<void> load(AssetBundle bundle) async {
    if (_fromDefine.isNotEmpty) return;
    try {
      final url = parseDotEnv(await bundle.loadString('.env'))['API_BASE_URL'];
      if (url != null && url.isNotEmpty) _apiBaseUrl = url;
    } on FlutterError {
      // No bundled .env: keep the default.
    }
  }
}
