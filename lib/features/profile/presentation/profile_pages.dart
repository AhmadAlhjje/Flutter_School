import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/settings/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/failure_message.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/auth_providers.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../auth/presentation/widgets/password_field.dart';
import '../../learning_providers.dart';
import '../domain/profile_entities.dart';

final _packageInfoProvider = FutureProvider<PackageInfo>((ref) => PackageInfo.fromPlatform());

/// Profile: name, phone and grade, language (when English is enabled), change password, logout.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.logout)),
        ],
      ),
    );
    if (confirmed == true) await ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(profileProvider);
    final locale = ref.watch(localeControllerProvider);
    final version = ref.watch(_packageInfoProvider).value?.version;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navAccount)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(profileProvider.future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            AsyncValueView<StudentProfile>(
              value: profile,
              onRetry: () => ref.invalidate(profileProvider),
              data: (data) => _ProfileDetails(profile: data),
            ),
            // Language choice: hidden while English is turned off (first release).
            if (englishEnabled) ...[
              SectionTitle(l10n.language),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'ar', label: Text(l10n.arabic)),
                  ButtonSegment(value: 'en', label: Text(l10n.english)),
                ],
                selected: {locale.languageCode},
                onSelectionChanged: (selection) =>
                    ref.read(localeControllerProvider.notifier).setLocale(Locale(selection.first)),
              ),
            ],
            const SizedBox(height: 20),
            ContentTile(
              title: l10n.changePassword,
              icon: Icons.lock_reset_rounded,
              onTap: () => context.push(Routes.changePassword),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
                side: const BorderSide(color: AppColors.danger),
              ),
              onPressed: () => _logout(context, ref),
              icon: const Icon(Icons.logout_rounded),
              label: Text(l10n.logout),
            ),
            if (version != null) ...[
              const SizedBox(height: 16),
              Text(
                l10n.appVersion(version),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.secondary, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primarySoft,
                  child: Icon(Icons.person_rounded, color: AppColors.primary, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profile.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      Text(
                        profile.phone,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(color: AppColors.secondary),
                      ),
                      if (profile.gradeName != null)
                        Text(profile.gradeName!, style: const TextStyle(color: AppColors.secondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(authRepositoryProvider)
          .changePassword(currentPassword: _current.text, newPassword: _next.text, confirmPassword: _confirm.text);
      messenger.showSnackBar(SnackBar(content: Text(l10n.passwordChanged)));
      if (mounted) context.pop();
    } catch (error) {
      if (mounted) setState(() => _error = failureMessage(l10n, error));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePassword)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(l10n.passwordChangeNote, style: const TextStyle(color: AppColors.secondary)),
            const SizedBox(height: 16),
            if (_error != null) ...[
              Semantics(
                liveRegion: true,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.dangerSoft, borderRadius: BorderRadius.circular(12)),
                  child: Text(_error!, style: const TextStyle(color: AppColors.danger)),
                ),
              ),
              const SizedBox(height: 16),
            ],
            PasswordField(
              controller: _current,
              label: l10n.currentPassword,
              validator: (value) => value == null || value.isEmpty ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 16),
            PasswordField(
              controller: _next,
              label: l10n.newPassword,
              helperText: l10n.passwordHint,
              validator: (value) {
                if (value == null || value.isEmpty) return l10n.fieldRequired;
                return isStrongPassword(value) ? null : l10n.errorWeakPassword;
              },
            ),
            const SizedBox(height: 16),
            PasswordField(
              controller: _confirm,
              label: l10n.confirmNewPassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              validator: (value) => value != _next.text ? l10n.passwordsDoNotMatch : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
