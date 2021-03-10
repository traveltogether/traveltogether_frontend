import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/chat_communication.dart';

class ChatRoomsPage extends StatefulWidget {
  final List chatRoomsList;
  ChatRoomsPage(this.chatRoomsList);

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState(this.chatRoomsList);
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  UserService currentUserService = new UserService();
  UserService chatUserService = new UserService();
  List<String> userNames = [""];
  int currentUserId;
  int participantIndex;

  _ChatRoomsPageState(chatRoomsList) {
    debugPrint("before ");
    currentUserService.getCurrentUser().then(
          (currentUser) {
            currentUserId = currentUser.id;
          debugPrint("after");
          userNames = new List(chatRoomsList.length);
          for (var i = 0; i < chatRoomsList.length; i++) {
            List<int> participants = chatRoomsList[i].participants;
            int index = participants.indexOf(currentUserId);
            if (index == 0){
              participantIndex = 1;
            }else if (index == 1){
              participantIndex = 0;
            }
            int userId = participants[participantIndex];
            debugPrint(userId.toString());
            chatUserService.getUser(userId).then(
                  (value) => setState(() {
                setState(() {
                  userNames[i] = value.username;
                });
              }),
            );
          }
        }
    );

  }

  void initState() {
    super.initState();
  }

  _onAddUser(int user_id, int chat_id) {
    var information = '{ "chat_id" : ' +
        user_id.toString() +
        ', "chat_id" : ' +
        chat_id.toString() +
        ' }';
    chat.send("ChatRoomAddUserPacket", information);
  }

  _onOpenChat(int id, String name) {
    List<String> information = [id.toString(), name];
    String info = information.join(',');
    chat.send('ChatRoomMessagesPacket', info);
  }

  Widget _chatRoomsList() {
    return widget.chatRoomsList.isEmpty
        ? Center(child: Text('Noch keine Chats vorhanden'))
        : ListView.builder(
            itemCount: widget.chatRoomsList.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return new ListTile(
                title: new Text(userNames[index]),
                trailing: new RaisedButton(
                  onPressed: () {
                    _onOpenChat(
                        widget.chatRoomsList[index].id, userNames[index]);
                  },
                  child: new Text('Chat'),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("travel together"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _chatRoomsList(),
          ],
        ),
        reverse: true,
      ),
    );
  }
}
