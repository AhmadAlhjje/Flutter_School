import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/content_tabs.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../../shared/widgets/teacher_avatar.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../../teachers/domain/teacher_entities.dart';
import '../domain/subject_entities.dart';

/// Subject screen: the teachers of the subject, each open or locked, and the subject files in a
/// second tab when the subject is open and has files.
class SubjectPage extends ConsumerWidget {
  const SubjectPage({super.key, required this.subjectId});

  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subject = ref.watch(subjectProvider(subjectId));
    return Scaffold(
      appBar: detailAppBar(),
      body: AsyncValueView<SubjectDetails>(
        value: subject,
        onRetry: () => ref.invalidate(subjectProvider(subjectId)),
        data: (data) => TabbedContent(
          onRefresh: () => ref.refresh(subjectProvider(subjectId).future),
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(title: data.name, description: data.description),
              if (data.locked) LockedBanner(message: l10n.lockedBody),
            ],
          ),
          tabs: [
            ContentTab(
              label: l10n.teachers,
              hint: l10n.hintChooseTeacher,
              emptyMessage: l10n.noTeachers,
              emptyIcon: Icons.person_outline_rounded,
              items: [for (final teacher in data.teachers) TeacherTile(teacher: teacher)],
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

class TeacherTile extends StatelessWidget {
  const TeacherTile({super.key, required this.teacher});

  final TeacherCard teacher;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.teacherTitle(teacher.name);
    final locked = teacher.locked;
    return Semantics(
      button: true,
      label: locked ? '$title، ${l10n.locked}' : title,
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => locked
              ? context.push(Uri(path: Routes.locked, queryParameters: {'title': title}).toString())
              : context.push(Routes.teacher(teacher.subjectTeacherId)),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 18, 12, 18),
            child: Row(
              children: [
                TeacherAvatar(name: teacher.name, imagePath: teacher.imagePath, size: 64, muted: locked),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: locked ? AppColors.secondary : AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (locked)
                        Text(l10n.lockedHint, style: const TextStyle(color: AppColors.secondary, fontSize: 13))
                      else
                        InfoPill(icon: Icons.menu_book_rounded, text: l10n.topicsCount(teacher.topicsCount)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (locked) const LockBadge() else const ForwardArrow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
