import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/auth_state_provider.dart';
import '/services/storage_service.dart';
import '../../controllers/auth.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await storage.read(key: StorageService.keyAccessToken);

    await Future.delayed(Duration.zero);

    if (token == null) {
      ref.read(authControllerProvider.notifier).logout();
    } else {
      ref.read(authControllerProvider.notifier).setAuthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthStatus>(authStateProvider, (prev, next) {
      if (prev == AuthStatus.authenticated &&
          next == AuthStatus.unauthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session expired. Please login again.')),
        );
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
