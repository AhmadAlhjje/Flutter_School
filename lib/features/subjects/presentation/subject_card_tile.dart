import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/content_tile.dart';
import '../domain/subject_entities.dart';

/// A subject as a full-width card: big icon, name, and either its teachers count (open) or how
/// to get access (locked). Locked subjects still open, to show their teachers with locks.
class SubjectCardTile extends StatelessWidget {
  const SubjectCardTile({super.key, required this.subject, this.showGrade = false});

  final SubjectCard subject;

  /// Adds the grade name, only to tell apart two subjects with the same name.
  final bool showGrade;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locked = subject.locked;
    final detail = [
      if (showGrade) subject.gradeName,
      locked ? l10n.lockedHint : l10n.teachersCount(subject.teachersCount),
    ].join(' · ');
    return Semantics(
      button: true,
      label: locked ? '${subject.name}، ${l10n.locked}' : subject.name,
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(Routes.subject(subject.id)),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 16, 12, 16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: locked ? AppColors.muted : AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    locked ? Icons.lock_rounded : Icons.menu_book_rounded,
                    color: locked ? AppColors.secondary : Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: locked ? AppColors.secondary : AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        detail,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.secondary, fontSize: 13),
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
      ),
    );
  }
}

/// Subjects one under the other; the grade is shown only for names that appear twice.
class SubjectList extends StatelessWidget {
  const SubjectList({super.key, required this.subjects});

  final List<SubjectCard> subjects;

  @override
  Widget build(BuildContext context) {
    final names = <String, int>{};
    for (final subject in subjects) {
      names[subject.name] = (names[subject.name] ?? 0) + 1;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final subject in subjects) ...[
          SubjectCardTile(subject: subject, showGrade: (names[subject.name] ?? 0) > 1),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
