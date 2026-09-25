import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/settings/locale_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _configureLogging();
  await AppConfig.load(rootBundle);

  final preferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      // Screens show their own retry buttons; automatic retries would only hide errors
      // (and re-send requests the server has already refused).
      retry: (_, _) => null,
      child: const StudentApp(),
    ),
  );
}

void _configureLogging() {
  Logger.root.level = kReleaseMode ? Level.WARNING : Level.INFO;
  Logger.root.onRecord.listen((record) {
    final error = record.error == null ? '' : ' | ${record.error}';
    debugPrint('[${record.level.name}] ${record.loggerName}: ${record.message}$error');
  });

  final log = Logger('uncaught');
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    log.severe(details.exceptionAsString(), details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    log.severe('Uncaught async error', error, stack);
    return true;
  };
}
