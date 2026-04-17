import 'package:app/services/storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;

  Future<void> connect({
    required String betID,
    Function(Map<String, dynamic>)? onNewBet,
  }) async {
    socket = io.io(
      "https://nash-9qh7.onrender.com",
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
  }

  void on(String event, Function(Map<String, dynamic>) callback) {
    socket.on(event, (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  void dispose() {
    socket.dispose();
  }
}
