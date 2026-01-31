import 'package:app/pages/group/groups.dart';
import 'package:app/pages/search/search.dart';
import 'package:app/widgets/sliding_shell_stack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/pages/bet/bet.dart';
import '/pages/login/login.dart';
import '/pages/register/register.dart';
import '/pages/home/home.dart';
import '/pages/main_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/group',
                builder: (context, state) => const GroupPage(),
              ),
            ],
          ),
        ],
        navigatorContainerBuilder: (context, navigationShell, children) {
          return SlidingShellStack(
            index: navigationShell.currentIndex,
            children: children,
          );
        },
      ),
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
    ],
  );
});
