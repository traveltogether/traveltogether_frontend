import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/view-models/chat_communication.dart';
import 'chat_rooms_page.dart';

class ChatMessagesPage extends StatefulWidget {
  final int chatRoomID;
  final List<ChatMessageViewModel> messagesList;
  ChatMessagesPage(this.chatRoomID, this.messagesList);
  @override
  _ChatMessagesPageState createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  List<dynamic> chatRoomList = <dynamic>[];

  void initState() {
    super.initState();
    chat.addListener(_onChatDataReceived);
  }

  @override
  void dispose() {
    chat.removeListener(_onChatDataReceived);
    super.dispose();
  }

  TextEditingController messageController = new TextEditingController();

  _onChatDataReceived(message) {
    switch (message["type"]) {
      case "ChatRoomLeaveUser":
        Navigator.pop(context);
        break;
      case "ChatMessagePacket":
        ChatMessageViewModel newMessage = message["chat_message"].entries.map( (entry) => ChatMessageViewModel(entry.id, entry.chat_id, entry.sender_id, entry.message, entry.time));
        widget.messagesList.add(newMessage);
        setState(() {});
        break;
    }
  }

  _onSendChat(message) {
    var information = '{ "chat_id" : ' + widget.chatRoomID.toString() + ', "message" : "' + message + '", "time" : ' + DateTime.now().millisecondsSinceEpoch.toString() + ' }';
    chat.send('ChatMessagePacket', information);
  }

  _onLeaveChat(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chat Verlassen?'),
        content: Text('Sind Sie sicher, dass Sie den Chat dauerhaft verlassen möchten?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () {
              var information = '{ "chat_id" : ' + widget.chatRoomID.toString() + ' }';
              chat.send("ChatRoomLeaveUser", information);
            },
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.chatRoomID.toString()),
                      SizedBox(height: 6,),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){
                    _onLeaveChat();
                  },
                  icon: Icon(Icons.exit_to_app_rounded,color: Colors.black,),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: widget.messagesList.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (widget.messagesList[index].sender_id == 1?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (widget.messagesList[index].sender_id == 1?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(widget.messagesList[index].message, style: TextStyle(fontSize: 15),),
                  ),
                ),
              );
            },
          ),
      Align( alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(width: 15,),
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(width: 15,),
              FloatingActionButton(
                onPressed: (){
                  _onSendChat(messageController.text);
                },
                child: Icon(Icons.send,color: Colors.white,size: 18,),
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
            ],

          ),
        ),
      ),
        ],
      ),
      /*Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                    color: Color(0x54FFFFFF),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(child: TextField(
                          style: TextStyle(
                              color: Colors.black54
                          ),
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(
                                  color: Colors.black54
                              ),
                              border: InputBorder.none
                          ),
                        )
                        ),
                        GestureDetector(
                          onTap: (){
                            print("message sent");
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0x36FFFFFF),
                                      const Color(0x0FFFFFF),
                                    ]
                                ),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            padding: EdgeInsets.all(12),
                            child: Image.asset("assets/images/send.png"),
                          ),
                        ),
                      ],
                    )
                ),
              )
          ],
        )
      )*/
    );
  }
}