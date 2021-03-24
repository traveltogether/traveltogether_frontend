import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

WebSocketsNotifications sockets = new WebSocketsNotifications();

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets =
      new WebSocketsNotifications._internal();

  factory WebSocketsNotifications() {
    return _sockets;
  }

  WebSocketsNotifications._internal();

  IOWebSocketChannel _channel;

  bool _isOn = false;

  bool _closed = true;

  ObserverList<Function> _listeners = new ObserverList<Function>();

  Future<void> initCommunication() async {
    if (_closed) {
      reset();
      var sharedPreferences = await SharedPreferences.getInstance();
      var serverAddress =
          "wss://api.traveltogether.eu/v1/websocket?token=${sharedPreferences.getString("authKey")}";

      _channel = new IOWebSocketChannel.connect(serverAddress);
      _channel.stream.listen(_onReceptionOfMessageFromServer,
          onDone: () => onClosed(null), onError: onClosed);
      _closed = false;
    }
  }

  onClosed(x) {
    try {
      reset();
    } catch (e) {
      print(e);
    }

    _closed = true;
  }

  bool isClosed() {
    return _closed;
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
      callback(message);
    });
  }
}
