import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'chat_search_page.dart';

class ChatRoomsPage extends StatefulWidget {
  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}
class _ChatRoomsPageState extends State<ChatRoomsPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("travel together"),
          automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatSearchPage())
          );
        },
      ),
    );
  }
}