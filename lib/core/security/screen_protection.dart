import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen capture protection — "maximum practical protection", not a guarantee (spec §38):
///
/// - Android: `FLAG_SECURE` is set natively on the activity for the whole app, so screenshots
///   and screen recordings show a black surface and the app is hidden in the recents preview.
/// - iOS: the OS does not allow blocking screenshots. The app detects screen recording /
///   mirroring (`UIScreen.isCaptured`) and hides video while it is active, and is notified of
///   screenshots after the fact. A camera pointed at the screen cannot be prevented anywhere;
///   the watermark exists to deter that.
class ScreenProtection {
  ScreenProtection({MethodChannel? methods, EventChannel? events, EventChannel? screenshots})
    : _methods = methods ?? const MethodChannel('edu.platform/screen'),
      _events = events ?? const EventChannel('edu.platform/screen/capture'),
      _screenshots = screenshots ?? const EventChannel('edu.platform/screen/screenshot');

  final MethodChannel _methods;
  final EventChannel _events;
  final EventChannel _screenshots;

  /// Emits once per screenshot taken while the app is in the foreground (iOS only; on Android
  /// FLAG_SECURE already blanks screenshots).
  Stream<void> screenshotsTaken() {
    if (!Platform.isIOS) return const Stream<void>.empty();
    return _screenshots.receiveBroadcastStream().map((_) {});
  }

  /// Emits `true` while the screen is being recorded or mirrored (iOS), `false` otherwise.
  Stream<bool> capturedChanges() {
    if (!Platform.isIOS) return const Stream<bool>.empty();
    return _events.receiveBroadcastStream().map((event) => event == true);
  }

  Future<bool> isCaptured() async {
    if (!Platform.isIOS) return false;
    try {
      return await _methods.invokeMethod<bool>('isCaptured') ?? false;
    } on PlatformException {
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
