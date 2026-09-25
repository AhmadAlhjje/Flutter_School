import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/security/screen_protection.dart';
import 'core/settings/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_controller.dart';
import 'features/videos/videos_providers.dart';

final _log = Logger('app');

class StudentApp extends ConsumerStatefulWidget {
  const StudentApp({super.key});

  @override
  ConsumerState<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends ConsumerState<StudentApp> {
  final _messenger = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription<void>? _screenshots;

  @override
  void initState() {
    super.initState();
    _screenshots = ref.read(screenProtectionProvider).screenshotsTaken().listen((_) {
      _messenger.currentState?.showSnackBar(const SnackBar(content: _ScreenshotNotice()));
    });
  }

  @override
  void dispose() {
    unawaited(_screenshots?.cancel());
    super.dispose();
  }

  /// Online sign-in (or session restore): drop offline copies the server no longer licenses.
  void _syncOfflineCopies(AuthState? previous, AuthState next) {
    if (next is! AuthSignedIn || next.offline) return;
    final downloads = ref.read(offlineDownloadsProvider);
    if (downloads == null) return;
    unawaited(
      downloads.sync().catchError((Object error, StackTrace stack) {
        _log.warning('Offline license sync failed', error, stack);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, _syncOfflineCopies);
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _messenger,
      theme: AppTheme.light(),
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}

class _ScreenshotNotice extends StatelessWidget {
  const _ScreenshotNotice();

  @override
  Widget build(BuildContext context) => Text(AppLocalizations.of(context).screenshotDetected);
}
