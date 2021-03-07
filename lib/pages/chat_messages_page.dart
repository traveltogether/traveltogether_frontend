import 'package:flutter/material.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/pages/database.dart';

class ChatMessagesPage extends StatefulWidget {
  final String chatRoomID;
  ChatMessagesPage(this.chatRoomID);

  @override
  _ChatMessagesPageState createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("travel together"),
          automaticallyImplyLeading: false
      ),
      body: Container(
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
      ),
    );
  }
}
