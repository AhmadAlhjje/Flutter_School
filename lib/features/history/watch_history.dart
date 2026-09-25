import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/settings/locale_controller.dart';
import '../auth/presentation/auth_controller.dart';

/// A video the student watched, and where they stopped.
class WatchEntry {
  const WatchEntry({
    required this.videoId,
    required this.title,
    required this.positionSeconds,
    required this.durationSeconds,
    required this.updatedAt,
  });

  factory WatchEntry.fromJson(Map<String, dynamic> json) => WatchEntry(
    videoId: json['videoId'] as String,
    title: json['title'] as String,
    positionSeconds: json['position'] as int,
    durationSeconds: json['duration'] as int,
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  final String videoId;
  final String title;
  final int positionSeconds;
  final int durationSeconds;
  final DateTime updatedAt;

  /// Watched to the end (the last seconds are usually the teacher saying goodbye).
  bool get finished => durationSeconds > 0 && positionSeconds >= durationSeconds - 15;

  double get fraction => durationSeconds <= 0 ? 0 : (positionSeconds / durationSeconds).clamp(0, 1).toDouble();

  Map<String, dynamic> toJson() => {
    'videoId': videoId,
    'title': title,
    'position': positionSeconds,
    'duration': durationSeconds,
    'updatedAt': updatedAt.toIso8601String(),
  };
}

/// "My videos": the latest videos the student watched and where they stopped, kept on this
/// phone per account (never sent anywhere). The player resumes from here.
class WatchHistory extends Notifier<List<WatchEntry>> {
  static const maxEntries = 40;

  /// Opening a video for a few seconds does not count as watching it.
  static const minWatchedSeconds = 5;

  String get _key {
    final auth = ref.read(authControllerProvider);
    return 'watch.history.${auth is AuthSignedIn ? auth.account.id : 'guest'}';
  }

  @override
  List<WatchEntry> build() {
    ref.watch(authControllerProvider);
    final raw = ref.watch(sharedPreferencesProvider).getString(_key);
    if (raw == null) return const [];
    try {
      return [for (final item in jsonDecode(raw) as List<dynamic>) WatchEntry.fromJson(item as Map<String, dynamic>)];
    } on Object {
      return const [];
    }
  }

  /// Remembers where the student is in [videoId] (most recent first).
  void record({
    required String videoId,
    required String title,
    required Duration position,
    required Duration duration,
  }) {
    final known = state.any((entry) => entry.videoId == videoId);
    if (!known && position.inSeconds < minWatchedSeconds) return;
    final entry = WatchEntry(
      videoId: videoId,
      title: title,
      positionSeconds: position.inSeconds,
      durationSeconds: duration.inSeconds,
      updatedAt: DateTime.now(),
    );
    _save([entry, ...state.where((item) => item.videoId != videoId)].take(maxEntries).toList());
  }

  /// Where to continue [videoId], or zero to start from the beginning.
  Duration resumeAt(String videoId) {
    final entry = state.where((item) => item.videoId == videoId).firstOrNull;
    if (entry == null || entry.finished || entry.positionSeconds < 10) return Duration.zero;
    return Duration(seconds: entry.positionSeconds);
  }

  void remove(String videoId) => _save(state.where((item) => item.videoId != videoId).toList());

  void _save(List<WatchEntry> entries) {
    state = entries;
    unawaited(
      ref.read(sharedPreferencesProvider).setString(_key, jsonEncode([for (final entry in entries) entry.toJson()])),
    );
  }
}

final watchHistoryProvider = NotifierProvider<WatchHistory, List<WatchEntry>>(WatchHistory.new);
