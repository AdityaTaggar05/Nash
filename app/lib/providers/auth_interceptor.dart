import 'package:app/models/user.dart';
import 'package:app/providers/auth_state_provider.dart';
import 'package:app/providers/dio_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);
  final Ref ref;

  bool _isRefreshing = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.read(key: StorageService.keyAccessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        final dio = ref.read(dioProvider);
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } else {
        await _logout();
      }
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;

    try {
      final refreshToken = await storage.read(
        key: StorageService.keyRefreshToken,
      );
      if (refreshToken == null) return false;

      final dio = Dio();
      final res = await dio.post(
        'https://nash-9qh7.onrender.com/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      await storage.write(
        key: StorageService.keyAccessToken,
        value: res.data['access_token'],
      );
      await storage.write(
        key: StorageService.keyAccessToken,
        value: res.data['refresh_token'],
      );

      return true;
    } catch (_) {
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _logout() async {
    await storage.deleteAll();

    ref.read(userProvider.notifier).state = null;
    ref.read(authStateProvider.notifier).state = AuthStatus.unauthenticated;
  }

  Future<void> login({required String email, required String password}) async {
    final dio = ref.read(dioProvider);

    final res = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    print(res);

    await storage.write(
      key: StorageService.keyAccessToken,
      value: res.data['access_token'],
    );
    await storage.write(
      key: StorageService.keyRefreshToken,
      value: res.data['refresh_token'],
    );

    final userRes = await dio.get('/users/${res.data['id']}');
    print(userRes);
    ref.read(userProvider.notifier).state = User.fromJson(userRes.data);

    ref.read(authStateProvider.notifier).state = AuthStatus.authenticated;
  }
}

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  return AuthInterceptor(ref);
});