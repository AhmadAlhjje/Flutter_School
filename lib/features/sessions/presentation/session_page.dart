import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tabs.dart';
import '../../../shared/widgets/locked_content.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../../videos/domain/video_entities.dart';
import '../../videos/presentation/download_button.dart';
import '../../videos/presentation/downloads_controller.dart';
import '../domain/session_entities.dart';

/// A class session: its videos and files, each in its own tab.
class SessionPage extends ConsumerWidget {
  const SessionPage({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionProvider(sessionId));
    return Scaffold(
      appBar: detailAppBar(),
      body: AsyncValueView<SessionDetails>(
        value: session,
        onRetry: () => ref.invalidate(sessionProvider(sessionId)),
        onLocked: () => const LockedContentView(),
        data: (data) => TabbedContent(
          onRefresh: () => ref.refresh(sessionProvider(sessionId).future),
          header: PageHeader(caption: data.topicTitle, title: data.title, description: data.description),
          tabs: [
            ContentTab(
              label: l10n.videos,
              hint: l10n.hintVideos,
              emptyMessage: l10n.noVideos,
              emptyIcon: Icons.video_library_outlined,
              items: [for (final video in data.videos) VideoTile(video: video)],
            ),
            ContentTab(
              label: l10n.files,
              hint: l10n.hintFiles,
              emptyMessage: l10n.noFiles,
              emptyIcon: Icons.description_outlined,
              items: [for (final file in data.files) FileTile(file: file)],
            ),
          ],
        ),
      ),
    );
  }
}

/// A lesson video. When it is downloaded, it plays from the device (works without internet).
class VideoTile extends ConsumerWidget {
  const VideoTile({super.key, required this.video});

  final VideoItem video;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final copy = ref.watch(downloadedCopyProvider(video.id));
    final download = ref.watch(downloadsControllerProvider.select((map) => map[video.id]));
    final duration = video.durationSeconds;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(copy != null ? Routes.offlinePlayer(copy.licenseId) : Routes.player(video.id)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 6, 10),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 48,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            if (duration != null)
                              Text(
                                formatDuration(Duration(seconds: duration)),
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(color: AppColors.secondary, fontSize: 13),
                              ),
                            if (copy != null) ...[
                              if (duration != null) const SizedBox(width: 8),
                              const Icon(Icons.offline_pin_rounded, size: 15, color: AppColors.success),
                              const SizedBox(width: 3),
                              Text(
                                l10n.downloadedOnDevice,
                                style: const TextStyle(
                                  color: AppColors.success,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  DownloadButton(videoId: video.id, title: video.title),
                ],
              ),
            ),
            if (download is DownloadRunning) DownloadProgressBar(status: download),
          ],
        ),
      ),
    );
  }
}

/// Under a video while it downloads: a moving bar, the percentage and how much arrived.
class DownloadProgressBar extends StatelessWidget {
  const DownloadProgressBar({super.key, required this.status});

  final DownloadRunning status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final starting = status.percent == 0 && status.bytes == 0;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: status.percent / 100),
              duration: const Duration(milliseconds: 400),
              builder: (context, value, _) => LinearProgressIndicator(
                value: starting ? null : value,
                minHeight: 6,
                backgroundColor: AppColors.primarySoft,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.downloading_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                starting ? l10n.downloadPreparing : l10n.downloadingPercent(status.percent),
                style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              if (status.bytes > 0)
                Text(formatBytes(status.bytes), style: const TextStyle(color: AppColors.secondary, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
