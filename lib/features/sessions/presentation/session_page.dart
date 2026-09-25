import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/locked_content.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../../videos/domain/video_entities.dart';
import '../../videos/presentation/download_button.dart';
import '../domain/session_entities.dart';

/// A class session (spec §74): its videos (play / download) and files.
class SessionPage extends ConsumerWidget {
  const SessionPage({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionProvider(sessionId));
    return Scaffold(
      appBar: AppBar(title: Text(session.value?.title ?? '')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(sessionProvider(sessionId).future),
        child: AsyncValueView<SessionDetails>(
          value: session,
          onRetry: () => ref.invalidate(sessionProvider(sessionId)),
          onLocked: () => const LockedContentView(),
          data: (data) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              PageHeader(caption: data.topicTitle, title: data.title, description: data.description),
              if (data.videos.isEmpty && data.files.isEmpty)
                EmptyView(message: l10n.noSessionContent, icon: Icons.video_library_outlined),
              if (data.videos.isNotEmpty) ...[
                SectionTitle(l10n.videos),
                for (final video in data.videos) ...[VideoTile(video: video), const SizedBox(height: 10)],
              ],
              FileSection(title: l10n.files, files: data.files),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.video});

  final VideoItem video;

  @override
  Widget build(BuildContext context) {
    final duration = video.durationSeconds;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.push(Routes.player(video.id)),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 6, 10),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 44,
                decoration: BoxDecoration(color: AppColors.text, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
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
                    if (duration != null)
                      Text(
                        formatDuration(Duration(seconds: duration)),
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(color: AppColors.secondary, fontSize: 13),
                      ),
                  ],
                ),
              ),
              DownloadButton(videoId: video.id, title: video.title),
            ],
          ),
        ),
      ),
    );
  }
}
