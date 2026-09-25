import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/locked_content.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../domain/topic_entities.dart';

/// A lesson (e.g. التفاضل): its sessions and lesson files.
class TopicPage extends ConsumerWidget {
  const TopicPage({super.key, required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topic = ref.watch(topicProvider(topicId));
    return Scaffold(
      appBar: AppBar(title: Text(topic.value?.title ?? '')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(topicProvider(topicId).future),
        child: AsyncValueView<TopicDetails>(
          value: topic,
          onRetry: () => ref.invalidate(topicProvider(topicId)),
          onLocked: () => const LockedContentView(),
          data: (data) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              PageHeader(
                caption: '${data.subjectName} · ${l10n.teacherTitle(data.teacherName)}',
                title: data.title,
                description: data.description,
              ),
              SectionTitle(l10n.sessions),
              if (data.sessions.isEmpty)
                EmptyView(message: l10n.noSessions, icon: Icons.event_note_outlined)
              else
                for (final session in data.sessions) ...[
                  ContentTile(
                    title: session.title,
                    subtitle: '${l10n.videosCount(session.videosCount)} · ${l10n.filesCount(session.filesCount)}',
                    icon: Icons.play_lesson_outlined,
                    onTap: () => context.push(Routes.session(session.id)),
                  ),
                  const SizedBox(height: 10),
                ],
              FileSection(title: l10n.topicFiles, files: data.files),
            ],
          ),
        ),
      ),
    );
  }
}
