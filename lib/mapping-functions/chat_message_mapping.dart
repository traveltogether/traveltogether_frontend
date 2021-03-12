import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';

ChatMessageViewModel mapChatMessageToViewModel(Map<String, dynamic> json) {

  int id = json["id"];
  int chat_id = json["chat_id"];
  int sender_id = json["sender_id"];
  String message = json["message"];
  int time = json["time"];

  ChatMessageViewModel chatMessage = new ChatMessageViewModel(id, chat_id, sender_id, message, time);
  return chatMessage;
}