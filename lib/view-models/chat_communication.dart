import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'chat_room_view_model.dart';
import 'web_socket.dart';

ChatCommunication chat = new ChatCommunication(); /// Again, application-level global variable

class ChatCommunication {
  static final ChatCommunication _chat = new ChatCommunication._internal();

  factory ChatCommunication(){
    return _chat;
  }

  ChatCommunication._internal(){
    sockets.initCommunication(); /// Let's initialize the WebSockets communication
    sockets.addListener(_onMessageReceived); /// and ask to be notified as soon as a message comes in
    sockets.send('ChatUnreadMessagesPacket');
  }

  _onMessageReceived(serverMessage){ /// Common handler for all received messages, from the server
    Map message = json.decode(serverMessage); /// As messages are sent as a String let's deserialize it to get the corresponding JSON object
    switch(message["type"]){ /// When the communication is established, the server returns the unique identifier of the player.
      case 'ChatUnreadMessagesPacket':
        List<ChatMessageViewModel> unreadChatMessagesInfo = message["chat_messages"].entries.map( (entry) => ChatMessageViewModel(entry.id, entry.chat_id, entry.sender_id, entry.message, entry.time)).toList();
        break;
      default:
        _listeners.forEach((Function callback){
          callback(message);
        });
        break;
    }
  }

  send(String type, String information) { /// Common method to send requests to the server
    if (type == 'ChatRoomsPacket' || type == 'ChatRoomUnreadMessagesPacket'){
      sockets.send(json.encode({ /// Send the action to the server. To send the message, we need to serialize the JSON
        "type": type
      }));
    } else if (type == 'ChatRoomMessagesPacket'){
      sockets.send(json.encode({
        "type": type,
        "chat_id": int.parse(information)
      }));
    } else if (type == 'ChatMessagePacket'){
      sockets.send(json.encode({
        "type": type,
        "chat_message": information
      }));
    } else{
      sockets.send(json.encode({
        "type": type,
        "information": information
      }));
    }
  }

  ObserverList<Function> _listeners = new ObserverList<Function>(); /// Listeners to allow the different pages to be notified when messages come in

  addListener(Function callback){ /// Adds a callback to be invoked in case of incoming notification
    _listeners.add(callback);
  }

  removeListener(Function callback){
    _listeners.remove(callback);
  }
}