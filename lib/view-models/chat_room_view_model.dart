class ChatRoomViewModel{
  int id;
  List<int> participants;
  bool group = false;

  ChatRoomViewModel(this.id, this.participants, this.group);

  void addUser(int user_id) {
   participants.add(user_id);
  }

  Map toJson() => {
    'participants': participants,
    'group': group,
  };
}

class ChatMessageViewModel{
  int id;
  int chat_id;
  int sender_id;
  String message;
  int time;

  ChatMessageViewModel(this.id, this.chat_id, this.sender_id, this.message, this.time,);

  Map toJson() => {
    'chat_id': chat_id,
    'message' : message,
    'time' : time,
  };

}