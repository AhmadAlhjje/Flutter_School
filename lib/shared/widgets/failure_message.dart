import '../../core/errors/app_failure.dart';
import '../../core/l10n/app_localizations.dart';

/// User-facing, localized text for a failure. Never shows technical details.
String failureMessage(AppLocalizations l10n, Object error) {
  final kind = error is AppFailure ? error.kind : FailureKind.unknown;
  return switch (kind) {
    FailureKind.network => l10n.errorNetwork,
    FailureKind.invalidCredentials => l10n.errorInvalidCredentials,
    FailureKind.sessionExpired => l10n.errorSessionExpired,
    FailureKind.deviceMismatch => l10n.deviceErrorBody,
    FailureKind.accountDisabled => l10n.accountDisabledBody,
    FailureKind.accessDenied => l10n.errorAccessDenied,
    FailureKind.notFound => l10n.errorNotFound,
    FailureKind.videoNotReady => l10n.errorVideoNotReady,
    FailureKind.validation => l10n.errorValidation,
    FailureKind.weakPassword => l10n.errorWeakPassword,
    FailureKind.invalidCurrentPassword => l10n.errorInvalidCurrentPassword,
    FailureKind.phoneTaken => l10n.errorPhoneTaken,
    FailureKind.registrationDisabled => l10n.errorRegistrationDisabled,
    FailureKind.rateLimited => l10n.errorRateLimited,
    FailureKind.offlineDisabled => l10n.errorOfflineDisabled,
    FailureKind.server || FailureKind.unknown => l10n.errorGeneric,
  };
}
