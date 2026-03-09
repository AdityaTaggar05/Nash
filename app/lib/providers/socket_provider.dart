import 'dart:async';

import 'package:app/services/socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketProvider = AsyncNotifierProvider.autoDispose
    .family<SocketProvider, SocketService, String>(SocketProvider.new);

class SocketProvider extends AsyncNotifier<SocketService> {
  late final String betID;

  SocketProvider(this.betID);

  @override
  FutureOr<SocketService> build() async {
    print("LOG: CONNECTING TO SOCKET");
    final socketService = SocketService();
    await socketService.connect(betID: betID);

    return socketService;
  }
}
