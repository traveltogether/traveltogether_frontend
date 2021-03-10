import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/pages/chat_messages_page.dart';
import 'package:traveltogether_frontend/pages/chat_rooms_page.dart';
import 'chat_room_view_model.dart';
import 'web_socket.dart';

ChatCommunication chat = new ChatCommunication();
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class ChatCommunication {
  static final ChatCommunication _chat = new ChatCommunication._internal();
  List<ChatMessageViewModel> chatRoomMessagesList;
  String userName;
  bool chatRoomAlreadyExists = false;
  int userId;

  factory ChatCommunication() {
    return _chat;
  }

  ChatCommunication._internal() {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
    sockets.send(json.encode({"type": "ChatUnreadMessagesPacket"}));
  }

  _onMessageReceived(serverMessage) {
    Map message = json.decode(serverMessage);
    switch (message["type"]) {
      case "ChatRoomsPacket":
        List<ChatRoomViewModel> chatRoomsList = List<ChatRoomViewModel>.from(
            message["chat_rooms"].map((i) => ChatRoomViewModel.fromJson(i)));
        if (chatRoomAlreadyExists == true){
          List<ChatRoomViewModel> chatRooms = chatRoomsList.where((chatRoom) => (chatRoom.participants.contains(userId)));
          if (chatRooms.length == 1){
            List<String> information = [chatRooms[0].id.toString(), userName];
            String info = information.join(',');
            chat.send('ChatRoomMessagesPacket', info);
          }
        }else{
          navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) => ChatRoomsPage(chatRoomsList)));
        }
        break;
      case "ChatUnreadMessagesPacket":
        List<ChatMessageViewModel> unreadChatMessagesList =
            List<ChatMessageViewModel>.from(message["chat_messages"]
                .map((i) => ChatMessageViewModel.fromJson(i)));
        break;
      case "ChatRoomMessagesPacket":
        chatRoomMessagesList = List<ChatMessageViewModel>.from(
            message["chat_messages"]
                .map((i) => ChatMessageViewModel.fromJson(i)));
        chatRoomMessagesList.sort((a, b) => a.time.compareTo(b.time));
        navigatorKey.currentState.push(new MaterialPageRoute(
            builder: (context) => new ChatMessagesPage(
                chatRoomMessagesList[0].chat_id,
                chatRoomMessagesList,
                userName)));
        break;
      case "ChatRoomCreatePacket":
        ChatRoomViewModel newChatRoom =
            message["information"].map((i) => ChatRoomViewModel.fromJson(i));
        navigatorKey.currentState.push(new MaterialPageRoute(
            builder: (context) =>
                new ChatMessagesPage(newChatRoom.id, [], userName)));
        break;
      default:
        _listeners.forEach((Function callback) {
          callback(message);
        });
        break;
    }
    switch (message["error"]) {
      case "privat_chat_already_exists":
        chatRoomAlreadyExists = true;
        debugPrint("privat_chat_already_exists");
        chat.send("ChatRoomsPacket", "");
    }
  }

  send(String type, information) {
    if (type == 'ChatRoomsPacket') {
      sockets.send(json.encode({"type": "ChatRoomsPacket"}));
    } else if (type == 'ChatRoomMessagesPacket') {
      List<String> info = information.split(',');
      userName = info[1];
      sockets.send(json.encode({"type": type, "chat_id": int.parse(info[0])}));
    } else if (type == 'ChatMessagePacket') {
      sockets.send(information);
    } else if (type == 'ChatRoomLeaveUserPacket') {
      sockets.send(json.encode({
        "type": "ChatRoomLeaveUserPacket",
        "information": {"chat_id": int.parse(information)}
      }));
    } else if (type == 'ChatRoomCreatePacket') {
      List<String> info = information.split(',');
      userId = int.parse(info[0]);
      userName = info[1];
      sockets.send(json.encode({
        "type": type,
        "information": {
          "participants": [int.parse(info[0])],
          "group": false,
        }
      }));
    } else {
      sockets.send(json.encode({"type": type, "information": information}));
    }
  }

  ObserverList<Function> _listeners = new ObserverList<Function>();

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }
}
