import 'package:flutter/material.dart';
import 'chat_messages_page.dart';
import 'package:traveltogether_frontend/view-models/chat_communication.dart';
import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';

class ChatRoomsPage extends StatefulWidget {
  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}
class _ChatRoomsPageState extends State<ChatRoomsPage> {
  List<ChatRoomViewModel> chatRoomsList = [];
  void initState() {
    super.initState();
    ///possibly call chatUnreadMessages here ?
    chat.addListener(_onChatDataReceived);
  }

  @override
  void dispose() {
    chat.removeListener(_onChatDataReceived);
    super.dispose();
  }

  _onChatDataReceived(message) {
    switch (message["type"]) {
      case 'ChatRoomsPacket':
        chatRoomsList = message["chat_rooms"].entries.map( (entry) => ChatRoomViewModel(entry.id, entry.participants, entry.group)).toList();
        break;
      case "ChatRoomMessagesPacket":
        List<ChatMessageViewModel> chatMessages = message["chat_messages"].entries.map( (entry) => ChatMessageViewModel(entry.id, entry.chat_id, entry.sender_id, entry.message, entry.time)).toList();
        Navigator.push(context, new MaterialPageRoute(
          builder: (BuildContext context) => new ChatMessagesPage(message["chat_id"], chatMessages),
        ));
    // force rebuild
        setState(() {});
        break;
      case "ChatRoomCreatePacket":
        ChatRoomViewModel newChatRoom = message["information"].entries.map( (entry) => ChatRoomViewModel(entry.id, entry.participants, entry.group));
        chatRoomsList.add(newChatRoom);
        Navigator.push(context, new MaterialPageRoute(
          builder: (BuildContext context) => new ChatMessagesPage(newChatRoom.id, []),
        ));
        setState(() {});
        break;
    }
  }

  _onCreateChat(int id, List<int> participants, bool group){
    group = false;
    var information = '{ "id" : ' + id.toString() + ', "participants" : ' + participants.toString() + ', "group" : ' + group.toString() + ' }';
    chat.send("ChatRoomCreatePacket", information);
  }

  _onAddUser(int user_id, int chat_id){
    var information = '{ "chat_id" : ' + user_id.toString() + ', "chat_id" : ' + chat_id.toString() + ' }';
    chat.send("ChatRoomAddUserPacket", information);
  }

  _onOpenChat(int id){
    String chatId = id.toString();
    chat.send('ChatRoomMessagesPacket', chatId);
  }

  Widget _chatRoomsList() {
    chat.send("ChatRoomsPacket", "");
    return chatRoomsList.isEmpty ? Center(child: Text('Noch keine Chats vorhanden')) : ListView.builder(
      itemCount: chatRoomsList.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10,bottom: 10),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        String senderID = chatRoomsList[index].participants.map((i) => i.toString()).join(",");
        return new ListTile(
          title: new Text(senderID),
          trailing: new RaisedButton(
            onPressed: (){
              _onOpenChat(chatRoomsList[index].id);
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
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatSearchPage())
          );
        },
      ),*/
    );
  }
}
