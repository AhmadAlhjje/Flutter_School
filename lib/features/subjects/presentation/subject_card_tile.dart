import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/content_tile.dart';
import '../domain/subject_entities.dart';

/// Each subject keeps one accent color everywhere (picked from its id), so students recognize it.
const _accents = [
  (Color(0xFF2563EB), Color(0xFF1D4ED8)),
  (Color(0xFF0D9488), Color(0xFF0F766E)),
  (Color(0xFF7C3AED), Color(0xFF6D28D9)),
  (Color(0xFFEA580C), Color(0xFFC2410C)),
  (Color(0xFF16A34A), Color(0xFF15803D)),
  (Color(0xFFDB2777), Color(0xFFBE185D)),
];

(Color, Color) subjectAccent(String subjectId) =>
    _accents[subjectId.codeUnits.fold<int>(0, (sum, unit) => sum + unit) % _accents.length];

/// A subject as a large full-width card: a colored book, the name, and its teachers (open) or how
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
    final (color, dark) = subjectAccent(subject.id);
    return Semantics(
      button: true,
      label: locked ? '${subject.name}، ${l10n.locked}' : subject.name,
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(Routes.subject(subject.id)),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 12, 20),
            child: Row(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: locked ? AppColors.muted : null,
                    gradient: locked
                        ? null
                        : LinearGradient(
                            colors: [color, dark],
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                          ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    locked ? Icons.lock_rounded : Icons.auto_stories_rounded,
                    color: locked ? AppColors.secondary : Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          height: 1.3,
                          color: locked ? AppColors.secondary : AppColors.text,
                        ),
                      ),
                      if (showGrade)
                        Text(subject.gradeName, style: const TextStyle(color: AppColors.secondary, fontSize: 13)),
                      const SizedBox(height: 10),
                      if (locked)
                        Text(
                          l10n.lockedHint,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.secondary, fontSize: 13),
                        )
                      else
                        InfoPill(
                          icon: Icons.groups_rounded,
                          text: l10n.teachersCount(subject.teachersCount),
                          color: color,
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
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}
