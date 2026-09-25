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
import '../../../shared/widgets/teacher_avatar.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../domain/teacher_entities.dart';

/// A teacher's space in a subject (spec §73): lessons and teacher-level files. The server
/// answers access-denied when the subject or the teacher is closed for this student.
class TeacherPage extends ConsumerWidget {
  const TeacherPage({super.key, required this.subjectTeacherId});

  final String subjectTeacherId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final space = ref.watch(teacherSpaceProvider(subjectTeacherId));
    return Scaffold(
      appBar: detailAppBar(),
      body: AsyncValueView<TeacherSpace>(
        value: space,
        onRetry: () => ref.invalidate(teacherSpaceProvider(subjectTeacherId)),
        onLocked: () => const LockedContentView(),
        data: (data) => TabbedContent(
          onRefresh: () => ref.refresh(teacherSpaceProvider(subjectTeacherId).future),
          header: PageHeader(
            leading: TeacherAvatar(name: data.teacherName, imagePath: data.imagePath, size: 56),
            caption: data.subjectName,
            title: l10n.teacherTitle(data.teacherName),
            description: data.description,
          ),
          tabs: [
            ContentTab(
              label: l10n.lessons,
              hint: l10n.hintChooseLesson,
              emptyMessage: l10n.noLessons,
              emptyIcon: Icons.menu_book_outlined,
              items: [
                for (final (index, topic) in data.topics.indexed)
                  ContentTile(
                    title: topic.title,
                    subtitle: l10n.sessionsCount(topic.sessionsCount),
                    leading: NumberBadge(index + 1),
                    onTap: () => context.push(Routes.topic(topic.id)),
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
