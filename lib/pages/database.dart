
class DatabaseMethods {
  List<ChatRoom> _chatRoom = [];

  List userList() {
    return [
      User(userName: "myusername000", userEmail: "my@username.de"),
      User(userName: "janedoe123", userEmail: "jane@doe.de"),
      User(userName: "johnsmith456", userEmail: "john@smith.co.uk"),
      User(userName: "donaldduck789", userEmail: "donald@duck.com"),
    ];
  }

  getUserByUsername(String username, List userlist) async {
    List<User> _searchList = [];
    if (username == "" || username == Constants.myUserName) {
      return _searchList;
    } else {
      for (int i = 0; i < userlist.length; i++) {
        if (userlist[i].userName.toLowerCase().contains(
            username.toLowerCase())) {
          _searchList.add(userlist[i]);
        }
      }
      return _searchList;
    }
  }

  getUserByUserEmail(String useremail, List userlist) async {
    List<User> _searchList = [];
    if (useremail == "") {
      return _searchList;
    } else {
      for (int i = 0; i < userlist.length; i++) {
        if (userlist[i].userEmail.toLowerCase().contains(
            useremail.toLowerCase())) {
          _searchList.add(userlist[i]);
        }
      }
      return _searchList;
    }
  }

  createChatRoom(int chatRoomID, chatRoomMap){
    _chatRoom.add(ChatRoom(chatRoomID: chatRoomID,chatRoomMap: chatRoomMap));
    return ChatRoom(chatRoomID: chatRoomID, chatRoomMap: chatRoomMap);
  }
}

class User {
  String userName;
  String userEmail;
  User({this.userName, this.userEmail});
}

class ChatRoom {
  Map chatRoomMap = Map<List, String>();
  int chatRoomID;
  ChatRoom({this.chatRoomID, this.chatRoomMap});
}

class Constants {
  static String myUserName = "myusername000";
}
