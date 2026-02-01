import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    }
    return User(id: "s", username: "s", email: "s");
  }

  void updateBalance(int newBalance) =>
      state = state.whenData((user) => user.copyWith(balance: newBalance));

  void clear() => state = const AsyncLoading();
}
