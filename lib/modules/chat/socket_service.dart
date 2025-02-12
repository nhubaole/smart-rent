import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final StreamController<Map<String, dynamic>> _messageStreamController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get messageStream =>
      _messageStreamController.stream;

  void initializeSocket({required String userId}) {
    socket = IO.io(
      'http://54.151.243.111:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setQuery({'userID': userId})
          .build(),
    );

    socket.onConnect((_) {
      print('Connected to the server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the server');
    });

    socket.on('receiveMessage', (data) {
      print('Received message: $data');
      _messageStreamController.add(data); // Add message to the stream
    });
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('sendMessage', message);
  }

  void disconnect() {
    _messageStreamController.close(); // Close the stream controller
    socket.disconnect();
  }
}
