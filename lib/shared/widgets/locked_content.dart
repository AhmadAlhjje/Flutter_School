import 'package:flutter/material.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';

/// Shown when the student opens something they have no access to (spec §30). The server
/// refuses the content anyway; this view explains what to do.
class LockedContentView extends StatelessWidget {
  const LockedContentView({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.muted,
              child: Icon(Icons.lock_rounded, size: 38, color: AppColors.secondary),
            ),
            const SizedBox(height: 20),
            Text(
              title ?? l10n.lockedTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.lockedBody,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.secondary, height: 1.7),
            ),
          ],
        ),
      ),
    );
  }
}

class LockedContentPage extends StatelessWidget {
  const LockedContentPage({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? AppLocalizations.of(context).lockedTitle)),
      body: LockedContentView(title: title),
    );
  }
}
