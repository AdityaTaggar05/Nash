import 'package:app/config/router.dart';
import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: Nash()));
}

class Nash extends ConsumerWidget {
  const Nash({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
