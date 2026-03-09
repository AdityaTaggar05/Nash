import 'dart:async';

import 'package:app/providers/dio_provider.dart';
import 'package:app/providers/socket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/message.dart';
import 'bet.dart';

final chatControllerProvider = AsyncNotifierProvider.autoDispose
    .family<ChatController, List<Message>, BetParams>(ChatController.new);

class ChatController extends AsyncNotifier<List<Message>> {
  late final BetParams params;

  ChatController(this.params);

  @override
  FutureOr<List<Message>> build() async {
    final dio = ref.read(dioProvider);
    final socketService = ref.watch(socketProvider(params.betID));

    socketService.whenData((service) {
      socketService.value!.on("new_message", _handleNewMessage);
    });

    var res = await dio.get(
      "/group/${params.groupID}/bet/${params.betID}/messages",
    );

    final List<Message> messages = res.data
        .map<Message>((message) => Message.fromJSON(message))
        .toList();

    return messages;
  }

  void _handleNewMessage(Map<String, dynamic> data) {
    print("LOG: NEW MESSAGE");
    final newMessage = Message.fromJSON(data);

    state = state.whenData((messages) {
      return List<Message>.from([newMessage, ...messages]);
    });
  }
}
