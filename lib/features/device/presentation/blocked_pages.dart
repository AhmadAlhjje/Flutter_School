import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/presentation/auth_controller.dart';

/// Account bound to another device (spec §16–17). The student cannot change the device;
/// only the super admin can reset it.
class DeviceErrorPage extends ConsumerWidget {
  const DeviceErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return _BlockedScaffold(
      icon: Icons.phonelink_lock_rounded,
      title: l10n.deviceErrorTitle,
      body: l10n.deviceErrorBody,
      action: l10n.backToLogin,
      onAction: () => ref.read(authControllerProvider.notifier).acknowledgeBlock(),
    );
  }
}

class AccountDisabledPage extends ConsumerWidget {
  const AccountDisabledPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return _BlockedScaffold(
      icon: Icons.person_off_outlined,
      title: l10n.accountDisabledTitle,
      body: l10n.accountDisabledBody,
      action: l10n.backToLogin,
      onAction: () => ref.read(authControllerProvider.notifier).acknowledgeBlock(),
    );
  }
}

class _BlockedScaffold extends StatelessWidget {
  const _BlockedScaffold({
    required this.icon,
    required this.title,
    required this.body,
    required this.action,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.dangerSoft,
                  child: Icon(icon, size: 40, color: AppColors.danger),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.secondary, height: 1.7),
                ),
                const SizedBox(height: 28),
                OutlinedButton(onPressed: onAction, child: Text(action)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
