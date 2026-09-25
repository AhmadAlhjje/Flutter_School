import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/state_views.dart';
import '../../learning_providers.dart';
import '../../subjects/presentation/subject_card_tile.dart';
import '../domain/grade_entities.dart';

/// All grades of the institute (spec §71).
class GradesPage extends ConsumerWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final grades = ref.watch(gradesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.grades)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(gradesProvider.future),
        child: AsyncValueView<List<GradeSummary>>(
          value: grades,
          onRetry: () => ref.invalidate(gradesProvider),
          data: (items) => items.isEmpty
              ? ListView(
                  children: [EmptyView(message: l10n.noGrades, icon: Icons.layers_outlined)],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final grade = items[index];
                    return ContentTile(
                      title: grade.name,
                      subtitle: l10n.subjectsCount(grade.subjectsCount),
                      icon: Icons.layers_outlined,
                      onTap: () => context.push(Routes.grade(grade.id)),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

/// The subjects of one grade, each with its lock state.
class GradeSubjectsPage extends ConsumerWidget {
  const GradeSubjectsPage({super.key, required this.gradeId});

  final String gradeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final grade = ref.watch(gradeSubjectsProvider(gradeId));
    return Scaffold(
      appBar: AppBar(title: Text(grade.value?.gradeName ?? l10n.grades)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(gradeSubjectsProvider(gradeId).future),
        child: AsyncValueView<GradeSubjects>(
          value: grade,
          onRetry: () => ref.invalidate(gradeSubjectsProvider(gradeId)),
          data: (data) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (data.subjects.isEmpty)
                EmptyView(message: l10n.noSubjects, icon: Icons.menu_book_outlined)
              else
                SubjectGrid(subjects: data.subjects),
            ],
          ),
        ),
      ),
    );
  }
}
