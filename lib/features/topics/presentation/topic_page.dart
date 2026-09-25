import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/content_tabs.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/locked_content.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../domain/topic_entities.dart';

/// A lesson (e.g. التفاضل): its sessions, and its files in a second tab when there are any.
class TopicPage extends ConsumerWidget {
  const TopicPage({super.key, required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topic = ref.watch(topicProvider(topicId));
    return Scaffold(
      appBar: detailAppBar(),
      body: AsyncValueView<TopicDetails>(
        value: topic,
        onRetry: () => ref.invalidate(topicProvider(topicId)),
        onLocked: () => const LockedContentView(),
        data: (data) => TabbedContent(
          onRefresh: () => ref.refresh(topicProvider(topicId).future),
          header: PageHeader(
            caption: '${data.subjectName} · ${l10n.teacherTitle(data.teacherName)}',
            title: data.title,
            description: data.description,
          ),
          tabs: [
            ContentTab(
              label: l10n.sessions,
              hint: l10n.hintChooseSession,
              emptyMessage: l10n.noSessions,
              emptyIcon: Icons.event_note_outlined,
              items: [
                for (final (index, session) in data.sessions.indexed)
                  ContentTile(
                    title: session.title,
                    subtitle: '${l10n.videosCount(session.videosCount)} · ${l10n.filesCount(session.filesCount)}',
                    leading: NumberBadge(index + 1),
                    onTap: () => context.push(Routes.session(session.id)),
                  ),
              ],
            ),
            if (data.files.isNotEmpty)
              ContentTab(
                label: l10n.files,
                hint: l10n.hintFiles,
                emptyMessage: l10n.noFiles,
                items: [for (final file in data.files) FileTile(file: file)],
              ),
          ],
        ),
      ),
    );
  }
}
