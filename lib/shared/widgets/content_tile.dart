import 'package:flutter/material.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';

/// A tappable row for catalog items (subject, teacher, lesson, session...). Locked items are
/// shown — the student can see them — but with a lock and muted styling (spec §30).
class ContentTile extends StatelessWidget {
  const ContentTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.icon = Icons.menu_book_rounded,
    this.locked = false,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final IconData icon;
  final bool locked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: onTap != null,
      label: locked ? '$title، ${l10n.locked}' : title,
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                leading ??
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: locked ? AppColors.muted : AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: locked ? AppColors.secondary : AppColors.primary),
                    ),
                const SizedBox(width: 12),
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
                          fontSize: 15,
                          color: locked ? AppColors.secondary : AppColors.text,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle!, style: const TextStyle(color: AppColors.secondary, fontSize: 13)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (locked)
                  const LockBadge()
                else
                  const Icon(Icons.chevron_right_rounded, color: AppColors.secondary, textDirection: TextDirection.ltr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LockBadge extends StatelessWidget {
  const LockBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_rounded, size: 14, color: AppColors.secondary),
          const SizedBox(width: 4),
          Text(
            AppLocalizations.of(context).locked,
            style: const TextStyle(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
