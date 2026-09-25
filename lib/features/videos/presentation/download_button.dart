import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/failure_message.dart';
import 'downloads_controller.dart';

/// Download-for-offline action for one video: idle → progress → downloaded (or failed + retry).
class DownloadButton extends ConsumerWidget {
  const DownloadButton({super.key, required this.videoId, required this.title});

  final String videoId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(downloadsControllerProvider.select((map) => map[videoId]));
    final downloaded =
        ref.watch(offlineVideosProvider).value?.any((video) => video.videoId == videoId && !video.expired) ?? false;

    void start() => ref.read(downloadsControllerProvider.notifier).start(videoId: videoId, title: title);

    if (status is DownloadRunning) {
      return Tooltip(
        message: l10n.downloadingPercent(status.percent),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: status.percent == 0 ? null : status.percent / 100,
                  strokeWidth: 3,
                ),
              ),
              Text('${status.percent}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      );
    }
    if (downloaded) {
      return Tooltip(
        message: l10n.downloaded,
        child: const SizedBox(
          width: 48,
          height: 48,
          child: Icon(Icons.download_done_rounded, color: AppColors.success),
        ),
      );
    }
    if (status is DownloadFailed) {
      return IconButton(
        tooltip: '${l10n.downloadFailed}: ${failureMessage(l10n, status.error)}',
        icon: const Icon(Icons.refresh_rounded, color: AppColors.danger),
        onPressed: start,
      );
    }
    return IconButton(
      tooltip: l10n.downloadOffline,
      icon: const Icon(Icons.download_rounded, color: AppColors.primary),
      onPressed: start,
    );
  }
}
