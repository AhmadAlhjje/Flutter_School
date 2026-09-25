import 'dart:async';

/// Why the server stopped accepting the current session.
enum SessionEndReason { expired, deviceMismatch, accountDisabled }

/// Broadcast channel from the network layer to the auth controller: the interceptor reports
/// that the session ended; the controller decides where the user goes (login, device error...).
class SessionEvents {
  final _controller = StreamController<SessionEndReason>.broadcast();

  Stream<SessionEndReason> get stream => _controller.stream;

  void emit(SessionEndReason reason) {
    if (!_controller.isClosed) _controller.add(reason);
  }

  Future<void> dispose() => _controller.close();
}
