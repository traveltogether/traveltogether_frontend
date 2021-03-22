import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';

ChatMessageViewModel mapChatMessageToViewModel(Map<String, dynamic> json) {
  int id = json["id"];
  int chatId = json["chat_id"];
  int senderId = json["sender_id"];
  String message = json["message"];
  int time = json["time"];

  ChatMessageViewModel chatMessage =
      new ChatMessageViewModel(id, chatId, senderId, message, time);
  return chatMessage;
}
