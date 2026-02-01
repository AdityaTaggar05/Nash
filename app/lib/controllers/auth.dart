import 'package:app/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/auth_state_provider.dart';
import '/providers/dio_provider.dart';
import '/services/storage_service.dart';

class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() => AuthStatus.loading;

  Future<void> logout() async {
    await storage.deleteAll();
    ref.read(userProvider.notifier).state = null;
    state = AuthStatus.unauthenticated;
  }

  void setAuthenticated() {
    state = AuthStatus.authenticated;
  }

  Future<void> login({required String email, required String password}) async {
    state = AuthStatus.loading;

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
    }
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);
