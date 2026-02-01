import 'package:app/pages/group_bets/group_bets.dart';
import 'package:app/pages/group_creation/group_creation.dart';
import 'package:app/pages/group_info/group_info.dart';
import 'package:app/pages/groups/groups.dart';
import 'package:app/pages/search/search.dart';
import 'package:app/pages/splash/splash.dart';
import 'package:app/providers/auth_state_provider.dart';
import 'package:app/utils/auth_router_notifier.dart';
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
  final authState = ref.watch(authStateProvider);
  final notifier = ref.watch(authRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: (_, state) {
      if (authState == AuthStatus.loading) return '/splash';

      final isLoggedIn = (authState == AuthStatus.authenticated);

      if (isLoggedIn &&
          (state.matchedLocation == "/auth/register" ||
              state.matchedLocation == "/auth/login")) {
        return "/home";
      }

      return null;
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
    ],
  );
});
