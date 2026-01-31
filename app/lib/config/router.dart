import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/pages/bet/bet.dart';
import '/pages/login/login.dart';
import '/pages/profile/profile.dart';
import '/pages/register/register.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/profile/123',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/bet/:bet_id',
        builder: (context, state) =>
            BetPage(betID: state.pathParameters["bet_id"]!),
      ),
      GoRoute(
        path: '/profile/:user_id',
        builder: (context, state) =>
            ProfilePage(userID: state.pathParameters["user_id"]!),
      ),
    ],
  );
});
