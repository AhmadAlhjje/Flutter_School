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
import '../widgets/brand_mark.dart';
import '../widgets/password_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
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
          .login(phone: normalizePhone(_phone.text), password: _password.text);
    } catch (error) {
      if (mounted) setState(() => _error = failureMessage(AppLocalizations.of(context), error));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final config = ref.watch(publicConfigProvider).value;
    final auth = ref.watch(authControllerProvider);
    final expired = auth is AuthSignedOut && auth.sessionExpired;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: BrandMark()),
                    const SizedBox(height: 20),
                    Text(
                      l10n.loginTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.loginSubtitle(config?.instituteName ?? l10n.appTitle),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.secondary),
                    ),
                    const SizedBox(height: 28),
                    if (_error != null || expired) ...[
                      _ErrorBanner(message: _error ?? l10n.errorSessionExpired),
                      const SizedBox(height: 16),
                    ],
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      decoration: InputDecoration(labelText: l10n.phone, prefixIcon: const Icon(Icons.phone_outlined)),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
                        return isValidPhone(value) ? null : l10n.invalidPhone;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _password,
                      label: l10n.password,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      validator: (value) => value == null || value.isEmpty ? l10n.fieldRequired : null,
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
                          : Text(l10n.login),
                    ),
                    if (config?.selfRegistration ?? false) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.noAccount, style: const TextStyle(color: AppColors.secondary)),
                          TextButton(onPressed: () => context.go(Routes.register), child: Text(l10n.createAccount)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: AppColors.dangerSoft, borderRadius: BorderRadius.circular(12)),
        child: Text(message, style: const TextStyle(color: AppColors.danger)),
      ),
    );
  }
}
