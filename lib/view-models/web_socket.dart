import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

WebSocketsNotifications sockets = new WebSocketsNotifications(); /// Application-level global variable to access the WebSockets

const String _SERVER_ADDRESS = "wss://api.traveltogether.eu/v1/websocket?token=8c1e32b2-0faa-4d54-9e00-ddb64b2c3b57"; /// Put your WebSockets server IP address and port number

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets = new WebSocketsNotifications._internal();

  factory WebSocketsNotifications(){
    return _sockets;
  }

  WebSocketsNotifications._internal();

  IOWebSocketChannel _channel; /// The WebSocket "open" channel

  bool _isOn = false; /// Is the connection established?

  /// Listeners
  ObserverList<Function> _listeners = new ObserverList<Function>(); /// List of methods to be called when a new message comes in.

  initCommunication() async { /// Initialization the WebSockets connection with the server
    reset(); /// Just in case, close any previous communication
    try {
      _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS); /// Open a new WebSocket communication
      _channel.stream.listen(_onReceptionOfMessageFromServer); /// Start listening to new notifications / messages
    } catch(e){
      /// General error handling
      /// TODO
    }
  }

  reset(){ /// Closes the WebSocket communication
    if (_channel != null){
      if (_channel.sink != null){
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  send(String message){ /// Sends a message to the server
    if (_channel != null){
      if (_channel.sink != null && _isOn){
        _channel.sink.add(message);
      }
    }
  }

  addListener(Function callback){  /// Adds a callback to be invoked in case of incoming notification
    _listeners.add(callback);
  }
  removeListener(Function callback){
    _listeners.remove(callback);
  }

  _onReceptionOfMessageFromServer(message){  /// Callback which is invoked each time that we are receiving a message from the server
    _isOn = true;
    _listeners.forEach((Function callback){
      callback(message);
    });
  }
}