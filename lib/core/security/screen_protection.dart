import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen capture protection — "maximum practical protection", not a guarantee:
///
/// - Android: `FLAG_SECURE` makes screenshots and screen recordings of the app black, and the
///   app's sound cannot be captured by any other app (Android 10+), so a recording contains
///   neither picture nor sound. On Android 15+ the app is also told when it is being recorded
///   and the player stops the video. The OS does not let an app prevent the recorder itself
///   from starting.
/// - iOS: screenshots cannot be blocked. The app detects screen recording / mirroring
///   (`UIScreen.isCaptured`) and stops the video while it is active, and warns after a screenshot.
/// - A camera pointed at the screen cannot be prevented by any app.
class ScreenProtection {
  ScreenProtection({MethodChannel? methods, EventChannel? events, EventChannel? screenshots})
    : _methods = methods ?? const MethodChannel('edu.platform/screen'),
      _events = events ?? const EventChannel('edu.platform/screen/capture'),
      _screenshots = screenshots ?? const EventChannel('edu.platform/screen/screenshot');

  final MethodChannel _methods;
  final EventChannel _events;
  final EventChannel _screenshots;

  static bool get _supported => Platform.isAndroid || Platform.isIOS;

  /// Emits once per screenshot taken while the app is in the foreground (iOS only; on Android
  /// FLAG_SECURE already blanks screenshots).
  Stream<void> screenshotsTaken() {
    if (!Platform.isIOS) return const Stream<void>.empty();
    return _screenshots.receiveBroadcastStream().map((_) {});
  }

  /// Emits `true` while the screen is being recorded or mirrored, `false` otherwise
  /// (iOS, and Android 15+).
  Stream<bool> capturedChanges() {
    if (!_supported) return const Stream<bool>.empty();
    return _events.receiveBroadcastStream().map((event) => event == true);
  }

  Future<bool> isCaptured() async {
    if (!_supported) return false;
    try {
      return await _methods.invokeMethod<bool>('isCaptured') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }
}

final screenProtectionProvider = Provider<ScreenProtection>((ref) => ScreenProtection());

/// Current capture state (initial value + live updates).
final screenCapturedProvider = StreamProvider<bool>((ref) async* {
  final protection = ref.watch(screenProtectionProvider);
  yield await protection.isCaptured();
  yield* protection.capturedChanges();
});
