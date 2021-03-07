import 'package:flutter/material.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/pages/chat_messages_page.dart';
import 'file:///C:/Users/AnandarL/Documents/semester%204/SWE%20II/traveltogether_frontend/lib/pages/database.dart';

class ChatSearchPage extends StatefulWidget {
  @override
  _ChatSearchPageState createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  List<User> _foundList = [];

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text, databaseMethods.userList()).then((val){
      setState(() {
        _foundList = val;
      });
    });
  }

  createChatroomAndStart({String userName}){
    if (userName != Constants.myUserName) {
      String chatRoomID = getChatRoomId(userName, Constants.myUserName);
      List<String> users = [userName, Constants.myUserName];
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatRoomID" : chatRoomID
      };
      DatabaseMethods().createChatRoom(chatRoomID, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMessagesPage(chatRoomID)));
    } else {
     print("You cannot message yourself lol");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17
              ),),
              Text(userEmail, style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17
              ),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatroomAndStart(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Message", style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
              ),),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchList() {
    return _foundList != null ? ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _foundList.length,
        itemBuilder: (context, index){
          return SearchTile(
            userName: _foundList[index].userName,
            userEmail: _foundList[index].userEmail,
          );
        }): Container();
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("travel together"),
          automaticallyImplyLeading: false
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: searchTextEditingController,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    hintText: "search username...",
                    hintStyle: TextStyle(
                      color: Colors.white54
                    ),
                    border: InputBorder.none
                  ),
                )
                ),
                GestureDetector(
                  onTap: (){
                    initiateSearch();
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
                    child: Image.asset("assets/images/search.png"),
                  ),
                ),
              ],
            )
            ),
          searchList()
          ]
        )
      )
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}