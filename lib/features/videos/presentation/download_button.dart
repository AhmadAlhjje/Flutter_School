import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/failure_message.dart';
import '../domain/video_entities.dart';
import '../videos_providers.dart';
import 'downloads_controller.dart';

/// The valid (not expired) copy of [videoId] on this device, if any.
final downloadedCopyProvider = Provider.autoDispose.family<OfflineVideo?, String>((ref, videoId) {
  final videos = ref.watch(offlineVideosProvider).value ?? const <OfflineVideo>[];
  return videos.where((video) => video.videoId == videoId && !video.expired).firstOrNull;
});

/// Download a video for offline viewing, in its place in the lesson:
/// idle → progress → on the device (with "remove from device"), or failed + retry.
class DownloadButton extends ConsumerWidget {
  const DownloadButton({super.key, required this.videoId, required this.title});

  final String videoId;
  final String title;

  Future<void> _remove(BuildContext context, WidgetRef ref, OfflineVideo copy) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteDownload),
        content: Text(l10n.deleteDownloadConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.deleteDownload),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(offlineDownloadsProvider)?.delete(copy.licenseId);
    ref.invalidate(offlineVideosProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(downloadsControllerProvider.select((map) => map[videoId]));
    final copy = ref.watch(downloadedCopyProvider(videoId));

    void start() => ref.read(downloadsControllerProvider.notifier).start(videoId: videoId, title: title);

    if (status is DownloadRunning) {
      return _LabeledAction(
        label: '${status.percent}%',
        tooltip: l10n.downloadingPercent(status.percent),
        icon: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(value: status.percent == 0 ? null : status.percent / 100, strokeWidth: 3),
        ),
      );
    }
    if (copy != null) {
      return PopupMenuButton<String>(
        tooltip: l10n.downloaded,
        padding: EdgeInsets.zero,
        onSelected: (_) => _remove(context, ref, copy),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'remove',
            child: Row(
              children: [
                const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
                const SizedBox(width: 10),
                Text(l10n.deleteDownload),
              ],
            ),
          ),
        ],
        child: _LabeledAction(
          label: l10n.downloadedShort,
          color: AppColors.success,
          icon: const Icon(Icons.download_done_rounded, color: AppColors.success),
        ),
      );
    }
    if (status is DownloadFailed) {
      return _LabeledAction(
        label: l10n.retryShort,
        tooltip: '${l10n.downloadFailed}: ${failureMessage(l10n, status.error)}',
        color: AppColors.danger,
        icon: const Icon(Icons.refresh_rounded, color: AppColors.danger),
        onTap: start,
      );
    }
    return _LabeledAction(
      label: l10n.download,
      tooltip: l10n.downloadOffline,
      icon: const Icon(Icons.download_rounded, color: AppColors.primary),
      onTap: start,
    );
  }
}

/// An icon with a short word under it, so the action is clear without explanation.
class _LabeledAction extends StatelessWidget {
  const _LabeledAction({
    required this.label,
    required this.icon,
    this.color = AppColors.primary,
    this.onTap,
    this.tooltip,
  });

  final String label;
  final Widget icon;
  final Color color;
  final VoidCallback? onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: 60,
      height: 52,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
    final action = onTap == null
        ? content
        : InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap, child: content);
    return tooltip == null ? action : Tooltip(message: tooltip, child: action);
  }
}
