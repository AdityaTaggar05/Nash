import '/providers/auth_state_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRouterNotifier extends ValueNotifier<int> {
  AuthRouterNotifier(this.ref) : super(0) {
    ref.listen(authStateProvider, (_, __) => value++);
  }

  final Ref ref;
}

final authRouterNotifierProvider = Provider<AuthRouterNotifier>((ref) {
  return AuthRouterNotifier(ref);
});
