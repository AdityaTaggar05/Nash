import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/controllers/auth.dart';
import '/models/user.dart';
import '/providers/dio_provider.dart';

final userControllerProvider = AsyncNotifierProvider<UserController, User>(
  UserController.new,
);

class UserController extends AsyncNotifier<User> {
  @override
  FutureOr<User> build() async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.get('/users/me');
      return User.fromJson(response.data);
    } catch (e) {
      print("LOG ERR: $e");
      ref.read(authControllerProvider.notifier).logout();
      return User(email: "", username: "", id: "", balance: 0);
    }
  }

  void updateBalance(int amount) => state = state.whenData(
    (user) => user.copyWith(balance: user.balance! + amount),
  );

  void clear() => state = const AsyncLoading();
}
