import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/video_entities.dart';
import '../videos_providers.dart';

/// Videos stored on this device for the signed-in account.
final offlineVideosProvider = FutureProvider.autoDispose<List<OfflineVideo>>((ref) async {
  final downloads = ref.watch(offlineDownloadsProvider);
  if (downloads == null) return const [];
  final videos = await downloads.list();
  return [...videos]..sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));
});

sealed class DownloadStatus {
  const DownloadStatus(this.title);

  final String title;
}

class DownloadRunning extends DownloadStatus {
  const DownloadRunning(super.title, this.percent);

  final int percent;
}

class DownloadFailed extends DownloadStatus {
  const DownloadFailed(super.title, this.error);

  final Object error;
}

/// In-progress and failed downloads, keyed by video id. Lives for the whole signed-in session
/// so a download keeps going while the student browses other screens.
class DownloadsController extends Notifier<Map<String, DownloadStatus>> {
  @override
  Map<String, DownloadStatus> build() {
    ref.watch(offlineDownloadsProvider);
    return const {};
  }

  bool isRunning(String videoId) => state[videoId] is DownloadRunning;

  Future<void> start({required String videoId, required String title}) async {
    final downloads = ref.read(offlineDownloadsProvider);
    if (downloads == null || isRunning(videoId)) return;
    _set(videoId, DownloadRunning(title, 0));
    try {
      await downloads.download(
        videoId,
        onProgress: (progress) {
          final percent = (progress * 100).clamp(0, 100).floor();
          final current = state[videoId];
          if (current is DownloadRunning && current.percent == percent) return;
          _set(videoId, DownloadRunning(title, percent));
        },
      );
      if (!ref.mounted) return;
      state = {...state}..remove(videoId);
      ref.invalidate(offlineVideosProvider);
    } catch (error) {
      _set(videoId, DownloadFailed(title, error));
    }
  }

  void dismiss(String videoId) => state = {...state}..remove(videoId);

  void _set(String videoId, DownloadStatus status) {
    if (!ref.mounted) return;
    state = {...state, videoId: status};
  }
}

final downloadsControllerProvider = NotifierProvider<DownloadsController, Map<String, DownloadStatus>>(
  DownloadsController.new,
);
