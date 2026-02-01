import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/storage_service.dart';
import '../../controllers/auth.dart';
import '../../controllers/user.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    ref.listenManual<AuthStatus>(authControllerProvider, (prev, next) {
      if (prev == AuthStatus.authenticated &&
          next == AuthStatus.unauthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session expired. Please login again.')),
        );
      }
    });

    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await storage.read(key: StorageService.keyAccessToken);

    if (token == null) {
      ref.read(authControllerProvider.notifier).logout();
    } else {
      await ref.read(userControllerProvider.future);

      final userState = ref.read(userControllerProvider);

      userState.when(
        data: (_) {
          ref.read(authControllerProvider.notifier).setAuthenticated();
        },
        error: (_, __) {
          ref.read(authControllerProvider.notifier).logout();
        },
        loading: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
