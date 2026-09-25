import 'secure_store.dart';

/// Holds the session tokens. The access token lives only in memory; the refresh token is kept
/// in secure storage so the session survives app restarts.
class TokenStore {
  TokenStore(this._secure);

  static const _refreshKey = 'auth.refresh_token';

  final SecureStore _secure;
  String? _accessToken;

  String? get accessToken => _accessToken;

  Future<String?> refreshToken() => _secure.read(_refreshKey);

  Future<void> save({required String accessToken, required String refreshToken}) async {
    _accessToken = accessToken;
    await _secure.write(_refreshKey, refreshToken);
  }

  Future<void> clear() async {
    _accessToken = null;
    await _secure.delete(_refreshKey);
  }
}
