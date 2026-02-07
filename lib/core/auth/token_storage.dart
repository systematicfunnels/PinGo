import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage.g.dart';

abstract class TokenStorage {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
}

class InMemoryTokenStorage implements TokenStorage {
  String? _token;

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<void> clearToken() async => _token = null;
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) {
  // TODO: Replace with SecureStorage or SharedPreferences implementation
  return InMemoryTokenStorage();
}
