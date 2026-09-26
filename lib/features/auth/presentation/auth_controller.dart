import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/network/api_error_mapper.dart';
import '../../../core/network/network_providers.dart';
import '../../../core/network/session_events.dart';
import '../auth_providers.dart';
import '../domain/entities/student_account.dart';

/// App-wide session state. The router redirects purely from this state (spec §101):
/// unknown → splash, signedOut → login, deviceBlocked → device error, disabled → account disabled.
sealed class AuthState {
  const AuthState();
}

class AuthUnknown extends AuthState {
  const AuthUnknown();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut({this.sessionExpired = false});

  /// True when the server ended the session (shown as a notice on the login screen).
  final bool sessionExpired;
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.account, {this.offline = false});

  final StudentAccount account;

  /// Started without network: the screens show what was saved on this phone (and the downloaded
  /// videos and files) until the server answers again.
  final bool offline;
}

class AuthDeviceBlocked extends AuthState {
  const AuthDeviceBlocked();
}

class AuthAccountDisabled extends AuthState {
  const AuthAccountDisabled();
}

class AuthController extends Notifier<AuthState> {
  StreamSubscription<SessionEndReason>? _events;
  Timer? _reconnectTimer;
  Future<void>? _reconnecting;

  /// While offline, the server is tried again this often (in the background, nothing to press).
  static const reconnectEvery = Duration(seconds: 15);

  @override
  AuthState build() {
    _events = ref.watch(sessionEventsProvider).stream.listen(_onSessionEnded);
    listenSelf((previous, next) => _onChanged(next));
    ref.onDispose(() {
      _events?.cancel();
      _reconnectTimer?.cancel();
    });
    Future<void>.microtask(_restore);
    return const AuthUnknown();
  }

  void _onChanged(AuthState next) {
    final offline = next is AuthSignedIn && next.offline;
    ref.read(offlineModeProvider).active = offline;
    if (offline) {
      _reconnectTimer ??= Timer.periodic(reconnectEvery, (_) => reconnect());
    } else {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }
    // Signed out (or blocked): nothing of this account stays readable on the phone, and the next
    // account to sign in starts with nothing saved.
    if (next is! AuthSignedIn && next is! AuthUnknown) unawaited(ref.read(responseCacheStoreProvider).clear());
  }

  Future<void> _restore() async {
    if (!ref.mounted) return;
    try {
      final restored = await ref.read(authRepositoryProvider).restoreSession();
      if (!ref.mounted) return;
      state = restored == null ? const AuthSignedOut() : AuthSignedIn(restored.account, offline: restored.offline);
    } catch (error) {
      if (!ref.mounted) return;
      state = _stateForFailure(toFailure(error)) ?? const AuthSignedOut();
    }
  }

  /// Throws [AppFailure] for the form to display. Session-level failures (device bound to
  /// another phone, disabled account) also move the app to the matching screen.
  Future<void> login({required String phone, required String password}) =>
      _signIn(() => ref.read(authRepositoryProvider).login(phone: phone, password: password));

  Future<void> register({required String name, required String phone, required String password, String? gradeId}) =>
      _signIn(
        () => ref.read(authRepositoryProvider).register(name: name, phone: phone, password: password, gradeId: gradeId),
      );

  Future<void> _signIn(Future<StudentAccount> Function() action) async {
    try {
      state = AuthSignedIn(await action());
    } catch (error) {
      final failure = toFailure(error);
      final next = _stateForFailure(failure);
      if (next != null) state = next;
      throw failure;
    }
  }

  /// Offline: try the server again (every [reconnectEvery], or on pull-to-refresh). Stays offline
  /// if it is still unreachable; moves to the right screen if the session ended meanwhile.
  Future<void> reconnect() => _reconnecting ??= _reconnect().whenComplete(() => _reconnecting = null);

  Future<void> _reconnect() async {
    final current = state;
    if (current is! AuthSignedIn || !current.offline) return;
    try {
      final restored = await ref.read(authRepositoryProvider).restoreSession();
      if (!ref.mounted) return;
      if (restored == null) {
        state = const AuthSignedOut();
      } else if (!restored.offline) {
        state = AuthSignedIn(restored.account);
      }
    } catch (error) {
      if (!ref.mounted) return;
      final next = _stateForFailure(toFailure(error));
      if (next != null) state = next;
    }
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthSignedOut();
  }

  /// Leaves the device-error / disabled screens back to the login screen.
  Future<void> acknowledgeBlock() async {
    await ref.read(tokenStoreProvider).clear();
    state = const AuthSignedOut();
  }

  void _onSessionEnded(SessionEndReason reason) {
    if (state is! AuthSignedIn) return;
    state = switch (reason) {
      SessionEndReason.expired => const AuthSignedOut(sessionExpired: true),
      SessionEndReason.deviceMismatch => const AuthDeviceBlocked(),
      SessionEndReason.accountDisabled => const AuthAccountDisabled(),
    };
  }

  AuthState? _stateForFailure(AppFailure failure) => switch (failure.kind) {
    FailureKind.deviceMismatch => const AuthDeviceBlocked(),
    FailureKind.accountDisabled => const AuthAccountDisabled(),
    FailureKind.sessionExpired => const AuthSignedOut(sessionExpired: true),
    _ => null,
  };
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(AuthController.new);

/// The signed-in account (throws if read while signed out — only used under signed-in routes).
final currentAccountProvider = Provider<StudentAccount?>((ref) {
  final state = ref.watch(authControllerProvider);
  return state is AuthSignedIn ? state.account : null;
});
