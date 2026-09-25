import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../../../shared/widgets/teacher_avatar.dart';
import '../../files/presentation/file_tile.dart';
import '../../learning_providers.dart';
import '../../teachers/domain/teacher_entities.dart';
import '../domain/subject_entities.dart';

/// Subject screen (spec §72): the teachers of the subject, each open or locked, plus
/// subject-level files when the subject is open.
class SubjectPage extends ConsumerWidget {
  const SubjectPage({super.key, required this.subjectId});

  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subject = ref.watch(subjectProvider(subjectId));
    return Scaffold(
      appBar: AppBar(title: Text(subject.value?.name ?? '')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(subjectProvider(subjectId).future),
        child: AsyncValueView<SubjectDetails>(
          value: subject,
          onRetry: () => ref.invalidate(subjectProvider(subjectId)),
          data: (data) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              PageHeader(caption: data.gradeName, title: data.name, description: data.description),
              if (data.locked) LockedBanner(message: l10n.lockedBody),
              SectionTitle(l10n.teachers),
              if (data.teachers.isEmpty)
                EmptyView(message: l10n.noTeachers, icon: Icons.person_outline_rounded)
              else
                for (final teacher in data.teachers) ...[TeacherTile(teacher: teacher), const SizedBox(height: 10)],
              FileSection(title: l10n.subjectFiles, files: data.files),
            ],
          ),
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
    return ContentTile(
      title: title,
      subtitle: teacher.locked ? null : l10n.topicsCount(teacher.topicsCount),
      locked: teacher.locked,
      leading: TeacherAvatar(name: teacher.name, imagePath: teacher.imagePath, muted: teacher.locked),
      onTap: () => teacher.locked
          ? context.push(Uri(path: Routes.locked, queryParameters: {'title': title}).toString())
          : context.push(Routes.teacher(teacher.subjectTeacherId)),
    );
  }
}
