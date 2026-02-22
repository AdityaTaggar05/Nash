import 'package:app/services/storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;

  Future<void> connect({
    required String betID,
    Function(Map<String, dynamic>)? onNewBet,
  }) async {
    socket = io.io(
      "http://10.81.94.34:3000",
      io.OptionBuilder()
          .setTransports(['websocket']) // use websocket
          .setPath("/socket.io/")
          .setAuth({
            'token': await storage.read(key: StorageService.keyAccessToken),
          })
          .setExtraHeaders({"Connection": "keep-alive"})
          .enableReconnection()
          .enableForceNew()
          .build(),
    );

    socket.onConnect((_) {
      socket.emit("join_room", {"roomID": betID});
    });

    socket.onConnectError((err) {
      print("LOG ❌ CONNECT ERROR: $err");
    });

    socket.onError((err) {
      print("LOG ❌ SOCKET ERROR: $err");
    });

    socket.onDisconnect((_) {
      print("LOG ⚠️ SOCKET DISCONNECTED");
    });

    socket.on("new_user_bet", (data) {
      print("LOG: New Bet Placed");
      onNewBet?.call(Map<String, dynamic>.from(data));
    });

    socket.on("new_message", (data) {
      print("LOG: New Message Received");
      // Handle new message if needed
    });
  }

  void dispose() {
    socket.dispose();
  }
}
