import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/pages/chat_messages_page.dart';
import 'package:traveltogether_frontend/pages/chat_rooms_page.dart';
import 'package:traveltogether_frontend/services/navigator_service.dart';
import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/widgets/type_enum.dart';

import 'web_socket.dart';

ChatCommunication chat = ChatCommunication();

class ChatCommunication {
  static final ChatCommunication _chat = new ChatCommunication._internal();
  List<ChatMessageViewModel> chatRoomMessagesList;
  String userName;
  bool chatRoomAlreadyExists = false;
  int userId;
  int currentUserId;
  int chatId;
  UserReadViewModel currentUser = new UserReadViewModel();

  factory ChatCommunication() {
    return _chat;
  }

  ChatCommunication._internal() {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
  }

  _onMessageReceived(serverMessage) {
    Map message = json.decode(serverMessage);
    switch (message["type"]) {
      case "ChatRoomsPacket":
        List<ChatRoomViewModel> chatRoomsList = [];
        (message["chat_rooms"] as List<dynamic>).forEach((element) =>
            chatRoomsList.add(ChatRoomViewModel.fromJson(element)));
        if (chatRoomAlreadyExists) {
          chatRoomsList.forEach((chatRoom) {
            List<int> participants = chatRoom.participants;
            participants.forEach((id) {
              if (id == userId) {
                List<String> information = [
                  chatRoom.id.toString(),
                  userId.toString(),
                  currentUserId.toString()
                ];
                String info = information.join(',');
                chatRoomAlreadyExists = false;
                chat.send(Type.ChatRoomMessagesPacket, info);
              }
            });
          });
        } else {
          navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) =>
                  ChatRoomsPage(chatRoomsList, currentUserId)));
        }
        break;
      case "ChatRoomMessagesPacket":
        chatRoomMessagesList = [];
        (message["chat_messages"] as List<dynamic>).forEach((element) =>
            chatRoomMessagesList.add(ChatMessageViewModel.fromJson(element)));
        chatRoomMessagesList.sort((a, b) => a.time.compareTo(b.time));
        navigatorKey.currentState.push(new MaterialPageRoute(
            builder: (context) => new ChatMessagesPage(
                chatId, chatRoomMessagesList, userId, currentUserId)));
        break;
      case "ChatRoomCreatePacket":
        ChatRoomViewModel newChatRoom =
            ChatRoomViewModel.fromJson(message["information"]);
        navigatorKey.currentState.push(new MaterialPageRoute(
            builder: (context) =>
                ChatMessagesPage(newChatRoom.id, [], userId, currentUserId)));
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
        chat.send(Type.ChatRoomsPacket, currentUserId.toString());
    }
  }

  send(Type type, [String information]) {
    sockets.initCommunication().then((e) {
      switch (type) {
        case Type.ChatMessagePacket:
          sockets.send(information);
          break;
        case Type.ChatRoomCreatePacket:
          List<String> info = information.split(',');
          userId = int.parse(info[0]);
          currentUserId = int.parse(info[1]);
          sockets.send(json.encode({
            "type": "ChatRoomCreatePacket",
            "information": {
              "participants": [userId],
              "group": false,
            }
          }));
          break;
        case Type.ChatRoomLeaveUserPacket:
          sockets.send(json.encode({
            "type": "ChatRoomLeaveUserPacket",
            "information": {"chat_id": int.parse(information)}
          }));
          break;
        case Type.ChatRoomAddUserPacket:
          break;
        case Type.ChatRoomMessagesPacket:
          List<String> info = information.split(',');
          chatId = int.parse(info[0]);
          userId = int.parse(info[1]);
          currentUserId = int.parse(info[2]);
          sockets.send(json.encode({
            "type": "ChatRoomMessagesPacket",
            "chat_id": int.parse(info[0])
          }));
          break;
        case Type.ChatRoomsPacket:
          currentUserId = int.parse(information);
          sockets.send(json.encode({"type": "ChatRoomsPacket"}));
          break;
      }
    }).catchError((e) => print(e));
  }

  ObserverList<Function> _listeners = new ObserverList<Function>();

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }
}
