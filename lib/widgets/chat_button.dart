import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/chat_communication.dart';

class ChatButton extends StatelessWidget {
  final int userId;
  final String userName;
  ChatButton(this.userId, this.userName);

  _onCreateChat(int userId, String userName){
    List<String> information = [userId.toString(), userName];
    String info = information.join(',');
    chat.send('ChatRoomCreatePacket', info);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        //debugPrint("Chat button pressed");
        _onCreateChat(this.userId, this.userName);
      }),
      child: Text("Chat"),
    );
  }
}