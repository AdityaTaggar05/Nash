import 'package:app/providers/auth_state_provider.dart';
import 'package:app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final token = await storage.read(key:StorageService.keyAccessToken);

    ref.read(authStateProvider.notifier).state = token == null
        ? AuthStatus.unauthenticated
        : AuthStatus.authenticated;
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
