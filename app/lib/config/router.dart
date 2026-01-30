import 'package:app/pages/home/home.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/register/register.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      GoRoute(path: '/home', builder: (context, state) => HomePage())
    ],
  );
});
