import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/failure_message.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/video_entities.dart';
import '../videos_providers.dart';
import 'downloads_controller.dart';

/// Videos downloaded for offline viewing (spec §37) and downloads still in progress.
class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    final auth = ref.read(authControllerProvider);
    final downloads = ref.read(offlineDownloadsProvider);
    // Online: drop copies whose license the server revoked or expired.
    if (downloads != null && auth is AuthSignedIn && !auth.offline) {
      try {
        await downloads.sync();
      } on Object {
        // Offline or server unavailable: keep showing local copies.
      }
    }
    return ref.refresh(offlineVideosProvider.future).then((_) {});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final videos = ref.watch(offlineVideosProvider);
    final running = ref.watch(downloadsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.downloads)),
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: AsyncValueView<List<OfflineVideo>>(
          value: videos,
          onRetry: () => ref.invalidate(offlineVideosProvider),
          data: (items) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(l10n.downloadsNote, style: const TextStyle(color: AppColors.primaryDark)),
                    ),
                  ],
                ),
              ),
              if (running.isNotEmpty) ...[
                SectionTitle(l10n.downloadsInProgress),
                for (final entry in running.entries) ...[
                  _RunningTile(videoId: entry.key, status: entry.value),
                  const SizedBox(height: 10),
                ],
              ],
              if (items.isEmpty && running.isEmpty)
                EmptyView(message: l10n.noDownloads, icon: Icons.download_outlined)
              else if (items.isNotEmpty) ...[
                SectionTitle(l10n.downloaded),
                for (final video in items) ...[_OfflineTile(video: video), const SizedBox(height: 10)],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RunningTile extends ConsumerWidget {
  const _RunningTile({required this.videoId, required this.status});

  final String videoId;
  final DownloadStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = this.status;
    final controller = ref.read(downloadsControllerProvider.notifier);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(status.title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            switch (status) {
              DownloadRunning(:final percent) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: percent == 0 ? null : percent / 100),
                  const SizedBox(height: 6),
                  Text(l10n.downloadingPercent(percent), style: const TextStyle(color: AppColors.secondary)),
                ],
              ),
              DownloadFailed(:final error) => Row(
                children: [
                  Expanded(
                    child: Text(
                      '${l10n.downloadFailed}: ${failureMessage(l10n, error)}',
                      style: const TextStyle(color: AppColors.danger),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.start(videoId: videoId, title: status.title),
                    child: Text(l10n.retry),
                  ),
                  IconButton(
                    tooltip: l10n.close,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => controller.dismiss(videoId),
                  ),
                ],
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _OfflineTile extends ConsumerWidget {
  const _OfflineTile({required this.video});

  final OfflineVideo video;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
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
    await ref.read(offlineDownloadsProvider)?.delete(video.licenseId);
    ref.invalidate(offlineVideosProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final expired = video.expired;
    final duration = video.durationSeconds;
    final details = [
      formatBytes(video.sizeBytes, locale: locale),
      if (duration != null) formatDuration(Duration(seconds: duration)),
    ].join(' · ');
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: expired ? null : () => context.push(Routes.offlinePlayer(video.licenseId)),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 4, 12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 44,
                decoration: BoxDecoration(
                  color: expired ? AppColors.muted : AppColors.text,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  expired ? Icons.history_toggle_off_rounded : Icons.play_arrow_rounded,
                  color: expired ? AppColors.secondary : Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    Text(details, style: const TextStyle(color: AppColors.secondary, fontSize: 12)),
                    Text(
                      expired ? l10n.downloadExpired : l10n.availableUntil(formatDate(video.expiresAt, locale)),
                      style: TextStyle(color: expired ? AppColors.warning : AppColors.secondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: l10n.deleteDownload,
                icon: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
                onPressed: () => _delete(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
