import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class SocketService {
  static const _url = 'http://45.129.87.38:6065';
  IO.Socket? socket;
  final _incoming = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onMessage => _incoming.stream;

  void connect({String? token}) {
    if (socket != null && socket!.connected) return;
    socket = IO.io(_url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': token != null ? {'token': token} : null,
    });
    socket!.connect();

    socket!.on('connect', (_) {
      // print('Socket connected: ${socket!.id}');
    });

    socket!.on('message', (data) {
      try {
        if (data is Map<String, dynamic>) _incoming.add(data);
        else _incoming.add({'payload': data});
      } catch (e) {
        _incoming.add({'payload': data});
      }
    });

    socket!.on('disconnect', (_) {
      // print('Socket disconnected');
    });
  }

  void send(String event, Map<String, dynamic> payload) {
    socket?.emit(event, payload);
  }

  void dispose() {
    socket?.dispose();
    _incoming.close();
  }
}
