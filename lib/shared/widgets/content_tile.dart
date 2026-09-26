import 'package:flutter/material.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';

/// A tappable row for catalog items (teacher, lesson, session, file...). Locked items stay
/// visible, muted, with a lock and a one-line explanation of how to get access.
class ContentTile extends StatelessWidget {
  const ContentTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.icon = Icons.menu_book_rounded,
    this.locked = false,
    this.onTap,
    this.badge,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final IconData icon;
  final bool locked;
  final VoidCallback? onTap;

  /// A small mark after the subtitle (e.g. "on this phone").
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = locked ? l10n.lockedHint : subtitle;
    return Semantics(
      button: onTap != null,
      label: locked ? '$title، ${l10n.locked}' : title,
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 10, 14),
            child: Row(
              children: [
                leading ?? IconBox(icon: locked ? Icons.lock_rounded : icon, muted: locked),
                const SizedBox(width: 14),
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
                          fontSize: 16,
                          color: locked ? AppColors.secondary : AppColors.text,
                        ),
                      ),
                      if (detail != null || badge != null) ...[
                        const SizedBox(height: 2),
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (detail != null)
                              Text(detail, style: const TextStyle(color: AppColors.secondary, fontSize: 13)),
                            if (badge != null && !locked) badge!,
                          ],
                        ),
                      ],
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

/// Rounded square with an icon, used at the start of rows.
class IconBox extends StatelessWidget {
  const IconBox({super.key, required this.icon, this.muted = false, this.size = 48});

  final IconData icon;
  final bool muted;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: muted ? AppColors.muted : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: muted ? AppColors.secondary : AppColors.primary, size: size * 0.5),
    );
  }
}

/// Position of a lesson or session (1, 2, 3...), so the order to follow is obvious.
class NumberBadge extends StatelessWidget {
  const NumberBadge(this.number, {super.key});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(14)),
      child: Text(
        '$number',
        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 18),
      ),
    );
  }
}

/// "Open" arrow pointing forward in the reading direction (left in Arabic, right in English).
class ForwardArrow extends StatelessWidget {
  const ForwardArrow({super.key});

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(color: AppColors.muted, shape: BoxShape.circle),
      child: Icon(
        rtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
        textDirection: TextDirection.ltr,
        color: AppColors.secondary,
        size: 22,
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

/// A small colored chip with an icon, e.g. "مدرسان" or "4 دروس".
class InfoPill extends StatelessWidget {
  const InfoPill({super.key, required this.icon, required this.text, this.color = AppColors.primary});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
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

/// A one-line "what to do here" hint shown above a list.
class HintLine extends StatelessWidget {
  const HintLine(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.touch_app_outlined, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(color: AppColors.secondary, fontSize: 13, height: 1.5)),
        ),
      ],
    );
  }
}
