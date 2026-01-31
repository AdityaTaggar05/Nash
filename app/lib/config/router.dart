import 'package:app/pages/group_creation/group_creation.dart';
import 'package:app/pages/group_info/group_info.dart';
import 'package:app/pages/groups/groups.dart';
import 'package:app/pages/search/search.dart';
import 'package:app/widgets/sliding_shell_stack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/pages/bet/bet.dart';
import '/pages/home/home.dart';
import '/pages/login/login.dart';
import '/pages/main_page.dart';
import '/pages/profile/profile.dart';
import '/pages/register/register.dart';

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
                path: '/groups',
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
      GoRoute(
        path: '/group_creation',
        builder: (context, state) => const GroupCreation(),
      ),
      GoRoute(
        path: '/groups/:group_id',
        builder: (context, state) =>
            GroupInfo(groupID: state.pathParameters["group_id"]!),
      ),
      GoRoute(
        path: '/profile/:user_id',
        builder: (context, state) =>
            ProfilePage(userID: state.pathParameters["user_id"]!),
      ),
    ],
  );
});
