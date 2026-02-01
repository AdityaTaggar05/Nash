import 'package:app/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/dio_provider.dart';
import '/services/storage_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() => AuthStatus.unknown;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  Future<void> logout() async {
    await storage.deleteAll();
    ref.read(userProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }

  void setAuthenticated() {
    state = AuthStatus.authenticated;
  }

  Future<void> login({required String email, required String password}) async {
    _isLoggingIn = true;
    ref.notifyListeners();

    try {
      final dio = ref.read(dioProvider);

      final res = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      await storage.write(
        key: StorageService.keyAccessToken,
        value: res.data['access_token'],
      );

      await storage.write(
        key: StorageService.keyRefreshToken,
        value: res.data['refresh_token'],
      );

      state = AuthStatus.authenticated;
    } catch (e) {
      state = AuthStatus.unauthenticated;
      rethrow;
    } finally {
      _isLoggingIn = false;
      ref.notifyListeners();
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    _isLoggingIn = true;
    ref.notifyListeners();

    try {
      final dio = ref.read(dioProvider);

      final res = await dio.post(
        '/auth/register',
        data: {'email': email, 'password': password, 'username': username},
      );

      await storage.write(
        key: StorageService.keyAccessToken,
        value: res.data['access_token'],
      );

      await storage.write(
        key: StorageService.keyRefreshToken,
        value: res.data['refresh_token'],
      );

      state = AuthStatus.authenticated;
    } catch (e) {
      state = AuthStatus.unauthenticated;
      rethrow;
    } finally {
      _isLoggingIn = false;
      ref.notifyListeners();
    }
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);
