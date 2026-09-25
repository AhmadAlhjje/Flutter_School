import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/state_views.dart';
import '../../videos/presentation/download_button.dart';
import '../watch_history.dart';

/// "My videos" tab: the latest videos watched on this phone; one tap continues where the
/// student stopped (from the downloaded copy when there is one).
class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final entries = ref.watch(watchHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHistory)),
      body: entries.isEmpty
          ? Center(
              child: EmptyView(message: l10n.historyEmpty, icon: Icons.smart_display_outlined),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                HintLine(l10n.historyHint),
                const SizedBox(height: 12),
                for (final entry in entries) ...[_HistoryTile(entry: entry), const SizedBox(height: 10)],
              ],
            ),
    );
  }
}

class _HistoryTile extends ConsumerWidget {
  const _HistoryTile({required this.entry});

  final WatchEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final copy = ref.watch(downloadedCopyProvider(entry.videoId));
    final finished = entry.finished;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(copy != null ? Routes.offlinePlayer(copy.licenseId) : Routes.player(entry.videoId)),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 4, 12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: finished ? AppColors.successSoft : AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  finished ? Icons.check_rounded : Icons.play_arrow_rounded,
                  color: finished ? AppColors.success : Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: entry.fraction,
                        minHeight: 5,
                        backgroundColor: AppColors.muted,
                        color: finished ? AppColors.success : AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      finished
                          ? l10n.watchedFully
                          : l10n.continueFrom(formatDuration(Duration(seconds: entry.positionSeconds))),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: finished ? AppColors.success : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                tooltip: l10n.removeFromHistory,
                onSelected: (_) => ref.read(watchHistoryProvider.notifier).remove(entry.videoId),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'remove',
                    child: Row(
                      children: [
                        const Icon(Icons.close_rounded, color: AppColors.secondary),
                        const SizedBox(width: 10),
                        Text(l10n.removeFromHistory),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
