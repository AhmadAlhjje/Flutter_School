import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/app_failure.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import 'failure_message.dart';

/// Loading / error / empty / data rendering for an [AsyncValue] — no screen is ever blank.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({super.key, required this.value, required this.data, this.onRetry, this.onLocked});

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  /// Rendered instead of the error view when the server says the content is locked.
  final Widget Function()? onLocked;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => const LoadingView(),
      error: (error, _) {
        if (onLocked != null && error is AppFailure && error.kind == FailureKind.accessDenied) return onLocked!();
        return ErrorView(error: error, onRetry: onRetry);
      },
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(label: AppLocalizations.of(context).loading, child: const CircularProgressIndicator()),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final offline = error is AppFailure && (error as AppFailure).kind == FailureKind.network;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.dangerSoft,
              child: Icon(offline ? Icons.wifi_off_rounded : Icons.error_outline_rounded, color: AppColors.danger),
            ),
            const SizedBox(height: 16),
            Text(l10n.errorLoading, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 6),
            Text(
              failureMessage(l10n, error),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.secondary),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh_rounded), label: Text(l10n.retry)),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.message, this.icon = Icons.inbox_outlined});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.muted,
            child: Icon(icon, color: AppColors.secondary),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
