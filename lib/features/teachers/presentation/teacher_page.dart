import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
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
    final name = space.value?.teacherName;
    return Scaffold(
      appBar: AppBar(title: Text(name == null ? '' : l10n.teacherTitle(name))),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(teacherSpaceProvider(subjectTeacherId).future),
        child: AsyncValueView<TeacherSpace>(
          value: space,
          onRetry: () => ref.invalidate(teacherSpaceProvider(subjectTeacherId)),
          onLocked: () => const LockedContentView(),
          data: (data) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              PageHeader(
                leading: TeacherAvatar(name: data.teacherName, imagePath: data.imagePath, size: 56),
                caption: data.subjectName,
                title: l10n.teacherTitle(data.teacherName),
                description: data.description,
              ),
              SectionTitle(l10n.lessons),
              if (data.topics.isEmpty)
                EmptyView(message: l10n.noLessons, icon: Icons.menu_book_outlined)
              else
                for (final topic in data.topics) ...[
                  ContentTile(
                    title: topic.title,
                    subtitle: l10n.sessionsCount(topic.sessionsCount),
                    icon: Icons.bookmark_outline_rounded,
                    onTap: () => context.push(Routes.topic(topic.id)),
                  ),
                  const SizedBox(height: 10),
                ],
              FileSection(title: l10n.teacherFiles, files: data.files),
            ],
          ),
        ),
      ),
    );
  }
}
