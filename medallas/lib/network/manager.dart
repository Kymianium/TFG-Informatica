import 'package:web_socket_channel/web_socket_channel.dart';

class Manager {
  static final Manager _instance = Manager._internal();
  WebSocketChannel channel;
  factory Manager() {
    return _instance;
  }
  Manager._internal()
      : channel = WebSocketChannel.connect(Uri.parse('ws://localhost:1729'));
}
