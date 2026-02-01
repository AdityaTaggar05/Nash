import 'package:flutter_riverpod/legacy.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated
}

final authStateProvider = StateProvider<AuthStatus>(
  (ref) => AuthStatus.loading
);

