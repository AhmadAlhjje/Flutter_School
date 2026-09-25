import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
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
              searchHint: l10n.findLesson,
              searchKeys: [for (final topic in data.topics) topic.title],
              items: [
                for (final (index, topic) in data.topics.indexed)
                  LessonTile(
                    number: index + 1,
                    title: topic.title,
                    sessionsCount: topic.sessionsCount,
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

/// A lesson of a teacher: its number, title and sessions, with a colored edge — simpler than
/// the teacher cards, and unlike the numbered session rows inside the lesson.
class LessonTile extends StatelessWidget {
  const LessonTile({
    super.key,
    required this.number,
    required this.title,
    required this.sessionsCount,
    required this.onTap,
  });

  final int number;
  final String title;
  final int sessionsCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: '${l10n.lessonNumber(number)}، $title',
      excludeSemantics: true,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ColoredBox(color: AppColors.primary, child: SizedBox(width: 6)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 18, 12, 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.lessonNumber(number),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, height: 1.35),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.play_lesson_outlined, size: 16, color: AppColors.secondary),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.sessionsCount(sessionsCount),
                                    style: const TextStyle(color: AppColors.secondary, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const ForwardArrow(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
