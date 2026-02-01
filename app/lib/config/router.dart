import 'package:app/controllers/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/pages/bet/bet.dart';
import '/pages/bet/bet_creation/bet_creation.dart';
import '/pages/groups/group_bets/group_bets.dart';
import '/pages/groups/group_creation/group_creation.dart';
import '/pages/groups/group_info/group_info.dart';
import '/pages/groups/groups.dart';
import '/pages/home/home.dart';
import '/pages/login/login.dart';
import '/pages/main_page.dart';
import '/pages/profile/profile.dart';
import '/pages/register/register.dart';
import '/pages/search/search.dart';
import '/pages/splash/splash.dart';
import '/providers/auth_state_provider.dart';
import '/widgets/sliding_shell_stack.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (_, state) {
      final location = state.matchedLocation;

      if (authState == AuthStatus.loading) {
        return location == '/splash' ? null : '/splash';
      }

      final isAuthRoute =
          location == '/auth/login' || location == '/auth/register';

      if (authState == AuthStatus.authenticated) {
        if (isAuthRoute || location == '/splash') {
          return '/home';
        }
        return null;
      }

      if (isAuthRoute) return null;

      return '/auth/login';
    },
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
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/auth/register',
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
        builder: (context, state) => ProfilePage(
          userID: state.pathParameters["user_id"]!,
          heroTags: state.extra as List<String>,
        ),
      ),
      GoRoute(
        path: '/groups/:group_id/bets',
        builder: (context, state) =>
            GroupBets(groupID: state.pathParameters["group_id"]!),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/group/:group_id/bet_creation',
        builder: (context, state) =>
            BetCreation(groupID: state.pathParameters["group_id"]!),
      ),
    ],
  );
});
