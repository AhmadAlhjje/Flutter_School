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
import 'features/learning_providers.dart';
import 'features/notifications/presentation/notifications_page.dart';
import 'features/videos/presentation/downloads_controller.dart';
import 'features/videos/videos_providers.dart';
import 'shared/widgets/feedback.dart';

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
      _show(const _Localized(_screenshotNotice), FeedbackTone.error);
    });
  }

  @override
  void dispose() {
    unawaited(_screenshots?.cancel());
    super.dispose();
  }

  void _show(Widget content, FeedbackTone tone) {
    _messenger.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(feedbackSnackBar(content, tone: tone));
  }

  void _onAuthChanged(AuthState? previous, AuthState next) {
    _syncOfflineCopies(next);
    // The server answers again after an offline start: fresh data everywhere, and say so.
    if (previous is AuthSignedIn && previous.offline && next is AuthSignedIn && !next.offline) {
      _refreshContent();
      _show(const _Localized(_backOnline), FeedbackTone.success);
    }
  }

  /// Every screen reloads from the server (open ones at once, the others when opened).
  void _refreshContent() {
    ref
      ..invalidate(homeProvider)
      ..invalidate(subjectProvider)
      ..invalidate(teacherSpaceProvider)
      ..invalidate(topicProvider)
      ..invalidate(sessionProvider)
      ..invalidate(profileProvider)
      ..invalidate(unreadCountProvider)
      ..invalidate(notificationsControllerProvider)
      ..invalidate(searchResultsProvider);
  }

  void _onDownloadEnded(DownloadOutcome? previous, DownloadOutcome? outcome) {
    if (outcome == null) return;
    _show(
      _Localized(
        (l10n) => outcome.succeeded ? l10n.videoDownloaded(outcome.title) : l10n.videoDownloadFailed(outcome.title),
      ),
      outcome.succeeded ? FeedbackTone.success : FeedbackTone.error,
    );
  }

  /// Online sign-in (or session restore): drop offline copies the server no longer licenses.
  void _syncOfflineCopies(AuthState next) {
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
    ref
      ..listen(authControllerProvider, _onAuthChanged)
      ..listen<DownloadOutcome?>(downloadOutcomeProvider, _onDownloadEnded);
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

String _screenshotNotice(AppLocalizations l10n) => l10n.screenshotDetected;
String _backOnline(AppLocalizations l10n) => l10n.backOnline;

/// Text resolved where the message is shown (the messenger sits above the app's pages).
class _Localized extends StatelessWidget {
  const _Localized(this.text);

  final String Function(AppLocalizations l10n) text;

  @override
  Widget build(BuildContext context) => Text(text(AppLocalizations.of(context)));
}
