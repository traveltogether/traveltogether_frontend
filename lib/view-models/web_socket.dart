import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

WebSocketsNotifications sockets = new WebSocketsNotifications();

const String _SERVER_ADDRESS =
    "wss://api.traveltogether.eu/v1/websocket?token=8c1e32b2-0faa-4d54-9e00-ddb64b2c3b57";

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets =
      new WebSocketsNotifications._internal();

  factory WebSocketsNotifications() {
    return _sockets;
  }

  WebSocketsNotifications._internal();

  IOWebSocketChannel _channel;

  bool _isOn = false;

  ObserverList<Function> _listeners = new ObserverList<Function>();

  initCommunication() async {
    reset();
    try {
      _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS);
      _channel.stream.listen(_onReceptionOfMessageFromServer);
    } catch (e) {
      /// TODO
    }
  }

  reset() {
    if (_channel != null) {
      if (_channel.sink != null) {
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  send(String message) {
    if (_channel != null) {
      _isOn = true;
      if (_channel.sink != null && _isOn) {
        debugPrint("message sent: " + message);
        _channel.sink.add(message);
      }
    }
  }

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }

  _onReceptionOfMessageFromServer(message) {
    _isOn = true;
    _listeners.forEach((Function callback) {
      debugPrint("message received: " + message);
      callback(message);
    });
  }
}
