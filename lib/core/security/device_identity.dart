import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../storage/secure_store.dart';

/// What the app tells the backend about this device when logging in (spec §16).
class DeviceDescriptor {
  const DeviceDescriptor({
    required this.identifier,
    required this.platform,
    this.model,
    this.osVersion,
    this.appVersion,
  });

  final String identifier;
  final String platform;
  final String? model;
  final String? osVersion;
  final String? appVersion;

  Map<String, Object?> toJson() => {
    'identifier': identifier,
    'platform': platform,
    if (model != null) 'model': model,
    if (osVersion != null) 'osVersion': osVersion,
    if (appVersion != null) 'appVersion': appVersion,
  };
}

/// Stable per-install device identifier used for device binding.
///
/// - Android: `ANDROID_ID` (per signing key + user + device; survives reinstalls).
/// - iOS: a random UUID kept in the Keychain (survives reinstalls on the same device).
///
/// It is one security layer among many (tokens, sessions, server checks), never the only one.
class DeviceIdentity {
  DeviceIdentity(this._secure, {MethodChannel? channel}) : _channel = channel ?? const MethodChannel(channelName);

  static const channelName = 'edu.platform/device';
  static const _fallbackKey = 'device.identifier';

  final SecureStore _secure;
  final MethodChannel _channel;
  String? _cached;

  Future<String> identifier() async {
    if (_cached != null) return _cached!;
    String? id;
    if (Platform.isAndroid) {
      try {
        final androidId = await _channel.invokeMethod<String>('androidId');
        if (androidId != null && androidId.isNotEmpty) id = 'android-$androidId';
      } on PlatformException {
        id = null;
      }
    }
    id ??= await _secure.read(_fallbackKey);
    if (id == null) {
      id = '${Platform.isIOS ? 'ios' : 'device'}-${const Uuid().v4()}';
      await _secure.write(_fallbackKey, id);
    }
    return _cached = id;
  }

  Future<DeviceDescriptor> describe() async {
    final id = await identifier();
    final info = DeviceInfoPlugin();
    final package = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      final android = await info.androidInfo;
      return DeviceDescriptor(
        identifier: id,
        platform: 'ANDROID',
        model: '${android.manufacturer} ${android.model}'.trim(),
        osVersion: 'Android ${android.version.release}',
        appVersion: package.version,
      );
    }
    final ios = await info.iosInfo;
    return DeviceDescriptor(
      identifier: id,
      platform: 'IOS',
      model: ios.utsname.machine,
      osVersion: '${ios.systemName} ${ios.systemVersion}',
      appVersion: package.version,
    );
  }
}
