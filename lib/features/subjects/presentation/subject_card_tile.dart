import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/subject_entities.dart';

/// Grid of subject cards (home and grade screens).
class SubjectGrid extends StatelessWidget {
  const SubjectGrid({super.key, required this.subjects});

  final List<SubjectCard> subjects;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisExtent: 128,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) => SubjectCardTile(subject: subjects[index]),
    );
  }
}

/// A subject card. Locked subjects stay visible and open their page (which lists the teachers
/// with their own locks); the server refuses any locked content regardless.
class SubjectCardTile extends StatelessWidget {
  const SubjectCardTile({super.key, required this.subject});

  final SubjectCard subject;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locked = subject.locked;
    return Semantics(
      button: true,
      label: locked ? '${subject.name}، ${l10n.locked}' : subject.name,
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => context.push(Routes.subject(subject.id)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: locked ? AppColors.muted : AppColors.primarySoft,
                      child: Icon(
                        locked ? Icons.lock_rounded : Icons.menu_book_rounded,
                        size: 18,
                        color: locked ? AppColors.secondary : AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    if (!locked) const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
                  ],
                ),
                const Spacer(),
                Text(
                  subject.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: locked ? AppColors.secondary : AppColors.text,
                  ),
                ),
                Text(
                  locked ? l10n.locked : l10n.teachersCount(subject.teachersCount),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.secondary, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
