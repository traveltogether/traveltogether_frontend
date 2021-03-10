import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/websockets/chat_communication.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';

class ChatRoomsPage extends StatefulWidget {
  final List chatRoomsList;
  final UserReadViewModel currentUser;

  ChatRoomsPage(this.chatRoomsList, this.currentUser);

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState(this.chatRoomsList, this.currentUser);
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  UserService userService = new UserService();
  List<int> userIds = [];

  _ChatRoomsPageState(chatRoomList, currentUser) {
    print(chatRoomList);
    chatRoomList.forEach((chatRoom) {
      List<int> participants = chatRoom.participants;
      participants.forEach((id) {
        if (id != currentUser.id) {
          debugPrint("id: " + id.toString());
          userIds.add(id);
        }
      });
    });
  }

  _onAddUser(int user_id, int chat_id) {
    var information = '{ "chat_id" : ' +
        user_id.toString() +
        ', "chat_id" : ' +
        chat_id.toString() +
        ' }';
    chat.send("ChatRoomAddUserPacket", information);
  }

  _onOpenChat(int chatId, int userId, int currentUserId) {
    List<String> information = [chatId.toString(), userId.toString(), currentUserId.toString()];
    String info = information.join(',');
    chat.send('ChatRoomMessagesPacket', info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("travel together"),
        automaticallyImplyLeading: false,
      ),
      body: widget.chatRoomsList.isEmpty
          ? Center(child: Text('Noch keine Chats vorhanden'))
          : ListView.builder(
              itemCount: widget.chatRoomsList.length,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return FutureBuilder<UserReadViewModel>(
                    future: userService.getUser(userIds[index]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListTile(
                          title: Text(snapshot.data.username),
                          trailing: ElevatedButton(
                            onPressed: () {
                              _onOpenChat(widget.chatRoomsList[index].id,
                                  snapshot.data.id, widget.currentUser.id);
                            },
                            child: new Text('Chat'),
                          ),
                        );
                      }
                    });
              }),
    );
  }
}
