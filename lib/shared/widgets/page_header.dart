import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Top bar of a catalog screen: only the back button, blended with the page, because the
/// [PageHeader] below already shows the title in large type.
PreferredSizeWidget detailAppBar() =>
    AppBar(backgroundColor: AppColors.background, scrolledUnderElevation: 0, toolbarHeight: 48);

/// Title block at the top of a catalog screen: breadcrumb-like caption, title, description.
class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, this.caption, this.description, this.leading});

  final String title;
  final String? caption;
  final String? description;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 14)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (caption != null)
                Text(
                  caption!,
                  style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600),
                ),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.4)),
              if (description != null && description!.trim().isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(description!, style: const TextStyle(color: AppColors.secondary, height: 1.6)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Notice shown on a subject the student has not been given.
class LockedBanner extends StatelessWidget {
  const LockedBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_rounded, color: AppColors.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: const TextStyle(color: AppColors.secondary, height: 1.6)),
          ),
        ],
      ),
    );
  }
}
