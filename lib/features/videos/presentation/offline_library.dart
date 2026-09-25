import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/state_views.dart';
import '../domain/video_entities.dart';
import 'downloads_controller.dart';

/// Videos on this device, organized as in the app: subject · teacher, then lesson › session.
/// Shown when the app has no internet (online, downloads appear in their own session).
class OfflineLibrary extends ConsumerWidget {
  const OfflineLibrary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final videos = ref.watch(offlineVideosProvider);
    return AsyncValueView<List<OfflineVideo>>(
      value: videos,
      onRetry: () => ref.invalidate(offlineVideosProvider),
      data: (items) {
        if (items.isEmpty) return EmptyView(message: l10n.noDownloads, icon: Icons.download_outlined);
        final groups = <String, List<OfflineVideo>>{};
        for (final video in items) {
          final teacher = video.teacherName == null ? null : l10n.teacherTitle(video.teacherName!);
          final key = [video.subjectName, teacher].whereType<String>().join(' · ');
          groups.putIfAbsent(key.isEmpty ? l10n.videos : key, () => []).add(video);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final entry in groups.entries) ...[
              SectionTitle(entry.key),
              for (final video in entry.value) ...[_OfflineVideoTile(video: video), const SizedBox(height: 10)],
            ],
          ],
        );
      },
    );
  }
}

class _OfflineVideoTile extends StatelessWidget {
  const _OfflineVideoTile({required this.video});

  final OfflineVideo video;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final expired = video.expired;
    final place = [video.topicTitle, video.sessionTitle].whereType<String>().join(' › ');
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: expired ? null : () => context.push(Routes.offlinePlayer(video.licenseId)),
        child: Padding(
          padding: const EdgeInsets.all(14),
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
                    if (place.isNotEmpty) Text(place, style: const TextStyle(color: AppColors.secondary, fontSize: 13)),
                    Text(
                      expired ? l10n.downloadExpired : l10n.availableUntil(formatDate(video.expiresAt, locale)),
                      style: TextStyle(color: expired ? AppColors.warning : AppColors.secondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
