import 'dart:async';

import 'package:app/providers/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/message.dart';
import '/services/socket_service.dart';
import 'bet.dart';

final chatControllerProvider = AsyncNotifierProvider.autoDispose
    .family<ChatController, List<Message>, BetParams>(ChatController.new);

class ChatController extends AsyncNotifier<List<Message>> {
  late final BetParams params;
  SocketService? _socketService;

  ChatController(this.params);

  @override
  FutureOr<List<Message>> build() async {
    final dio = ref.read(dioProvider);
    var res = await dio.get(
      "/group/${params.groupID}/bet/${params.betID}/messages",
    );

    final List<Message> messages = res.data
        .map<Message>((message) => Message.fromJSON(message))
        .toList();

    // _socketService = SocketService();
    // await _socketService!.connect(betID: params.betID);

    return messages;
  }
}
