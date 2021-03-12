import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:traveltogether_frontend/services/user_service.dart';
import 'package:traveltogether_frontend/view-models/chat_room_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/websockets/chat_communication.dart';
import 'package:traveltogether_frontend/widgets/type_enum.dart';

class ChatMessagesPage extends StatefulWidget {
  final int chatRoomID;
  final List messagesList;
  final int userId;
  final int currentUserId;

  ChatMessagesPage(
      this.chatRoomID, this.messagesList, this.userId, this.currentUserId);

  @override
  _ChatMessagesPageState createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  UserService userService = new UserService();
  TextEditingController messageController = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    chat.addListener(_onMessageAction);
  }

  @override
  void dispose() {
    chat.removeListener(_onMessageAction);
    super.dispose();
  }

  _refreshPage() {
    setState(() {});
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 50), curve: Curves.fastOutSlowIn);
  }

  _onMessageAction(message) {
    switch (message["type"]) {
      case 'ChatMessagePacket':
        ChatMessageViewModel newMessage =
            new ChatMessageViewModel.fromJson(message["chat_message"]);
        widget.messagesList.add(newMessage);
        _refreshPage();
        break;
      case "ChatRoomLeaveUserPacket":
        setState(() {
          chat.send(Type.ChatRoomsPacket, "");
        });
        break;
    }
  }

  _onSendChat(message) {
    messageController.clear();
    chat.send(
        Type.ChatMessagePacket,
        json.encode({
          "type": "ChatMessagePacket",
          "chat_message": {"chat_id": widget.chatRoomID, "message": message}
        }));
  }

  _onLeaveChat() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Chat Verlassen?'),
            content: Text(
                'Sind Sie sicher, dass Sie den Chat dauerhaft verlassen möchten?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  chat.send(
                      Type.ChatRoomLeaveUserPacket, widget.chatRoomID.toString());
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 100),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
              padding: EdgeInsets.only(right: 16),
              child: FutureBuilder<UserReadViewModel>(
                  future: userService.getUser(widget.userId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          CircleAvatar(
                            //backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                            maxRadius: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(snapshot.data.username),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _onLeaveChat();
                            },
                            icon: Icon(
                              Icons.exit_to_app_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    }
                  })),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            controller: _scrollController,
            itemCount: widget.messagesList.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 75),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (widget.messagesList[index].sender_id !=
                          widget.currentUserId
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (widget.messagesList[index].sender_id !=
                              widget.currentUserId
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      widget.messagesList[index].message,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _onSendChat(messageController.text);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}