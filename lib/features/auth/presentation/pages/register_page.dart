import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/failure_message.dart';
import '../../auth_providers.dart';
import '../auth_controller.dart';
import '../widgets/password_field.dart';

/// Self-registration: name, phone, the student's grade and a password.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  String? _gradeId;
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    for (final controller in [_name, _phone, _password, _confirm]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .register(
            name: _name.text.trim(),
            phone: normalizePhone(_phone.text),
            password: _password.text,
            gradeId: _gradeId,
          );
    } catch (error) {
      if (mounted) setState(() => _error = failureMessage(AppLocalizations.of(context), error));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final grades = ref.watch(gradeOptionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.registerTitle),
        leading: BackButton(onPressed: () => context.go(Routes.login)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.dangerSoft, borderRadius: BorderRadius.circular(12)),
                    child: Text(_error!, style: const TextStyle(color: AppColors.danger)),
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: l10n.fullName, prefixIcon: const Icon(Icons.person_outline)),
                  validator: (value) => value == null || value.trim().isEmpty ? l10n.fieldRequired : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: l10n.phone, prefixIcon: const Icon(Icons.phone_outlined)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
                    return isValidPhone(value) ? null : l10n.invalidPhone;
                  },
                ),
                const SizedBox(height: 16),
                ...grades.when(
                  data: (options) => [
                    if (options.isNotEmpty) ...[
                      DropdownButtonFormField<String>(
                        initialValue: _gradeId,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: l10n.yourGrade,
                          prefixIcon: const Icon(Icons.school_outlined),
                        ),
                        hint: Text(l10n.chooseGrade),
                        items: [
                          for (final grade in options) DropdownMenuItem(value: grade.id, child: Text(grade.name)),
                        ],
                        onChanged: (value) => setState(() => _gradeId = value),
                        validator: (value) => value == null ? l10n.chooseGrade : null,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                  loading: () => [const LinearProgressIndicator(), const SizedBox(height: 16)],
                  error: (_, _) => [
                    Row(
                      children: [
                        Expanded(
                          child: Text(l10n.gradesUnavailable, style: const TextStyle(color: AppColors.secondary)),
                        ),
                        TextButton(onPressed: () => ref.invalidate(gradeOptionsProvider), child: Text(l10n.retry)),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                PasswordField(
                  controller: _password,
                  label: l10n.password,
                  helperText: l10n.passwordHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.fieldRequired;
                    return isStrongPassword(value) ? null : l10n.errorWeakPassword;
                  },
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _confirm,
                  label: l10n.confirmPassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  validator: (value) => value != _password.text ? l10n.passwordsDoNotMatch : null,
                ),
                const SizedBox(height: 12),
                Text(l10n.deviceNotice, style: const TextStyle(color: AppColors.secondary, fontSize: 12)),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                      : Text(l10n.register),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.haveAccount, style: const TextStyle(color: AppColors.secondary)),
                    TextButton(onPressed: () => context.go(Routes.login), child: Text(l10n.login)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
