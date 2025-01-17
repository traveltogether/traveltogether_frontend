import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/websockets/chat_communication.dart';
import 'package:traveltogether_frontend/widgets/type_enum.dart';

class ChatButton extends StatelessWidget {
  final int userId;
  final int currentUserId;

  ChatButton(this.userId, this.currentUserId);

  _onCreateChat() {
    List<String> information = [
      this.userId.toString(),
      this.currentUserId.toString()
    ];
    String info = information.join(',');
    chat.send(Type.ChatRoomCreatePacket, info);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        _onCreateChat();
      }),
      child: Text("Chat"),
    );
  }
}
