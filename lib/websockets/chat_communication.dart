import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/pages/chat_messages_page.dart';
import 'package:traveltogether_frontend/pages/chat_rooms_page.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';
import 'web_socket.dart';

ChatCommunication chat = new ChatCommunication();
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

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
    sockets.send(json.encode({"type": "ChatUnreadMessagesPacket"}));
  }

  _onMessageReceived(serverMessage) {
    Map message = json.decode(serverMessage);
    switch (message["type"]) {
      case "ChatRoomsPacket":
        List<ChatRoomViewModel> chatRoomsList = List<ChatRoomViewModel>.from(
            message["chat_rooms"].map((i) => ChatRoomViewModel.fromJson(i)));
        if (chatRoomAlreadyExists == true){
          chatRoomsList.forEach((chatRoom) {
            List<int> participants = chatRoom.participants;
            participants.forEach((id) {
              if (id == userId) {
                List<String> information = [chatRoom.id.toString(), userId.toString(), currentUserId.toString()];
                debugPrint("id: " + id.toString());
                String info = information.join(',');
                chatRoomAlreadyExists == false;
                chat.send('ChatRoomMessagesPacket', info);
              }
            });
          });
        }else{
          navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) => ChatRoomsPage(chatRoomsList, currentUser)));
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
                chatId,
                chatRoomMessagesList,
                userId,
            currentUserId)));
        break;
      case "ChatRoomCreatePacket":

        ChatRoomViewModel newChatRoom =
            message["information"].map((i) => ChatRoomViewModel.fromJson(i));
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
        print("HELLO: " + currentUserId.toString());
        chatRoomAlreadyExists = true;
        debugPrint("privat_chat_already_exists");
        chat.send("ChatRoomsPacket", "");
    }
  }

  send(String type, String information, [UserReadViewModel user] ) {
    if (type == 'ChatRoomsPacket') {
      currentUser = user;
      sockets.send(json.encode({"type": "ChatRoomsPacket"}));
    } else if (type == 'ChatRoomMessagesPacket') {
      List<String> info = information.split(',');
      chatId = int.parse(info[0]);
      userId = int.parse(info[1]);
      currentUserId = int.parse(info[2]);
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
      currentUserId = int.parse(info[1]);

      sockets.send(json.encode({
        "type": type,
        "information": {
          "participants": [userId],
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
