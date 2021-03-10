import 'package:flutter/material.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/websockets/chat_communication.dart';

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
    chat.send('ChatRoomCreatePacket', info);
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
