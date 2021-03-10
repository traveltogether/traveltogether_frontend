class ChatRoomViewModel{
  int id;
  List<int> participants;
  bool group = false;

  ChatRoomViewModel(this.id, this.participants, this.group);

  void addUser(int user_id) {
   participants.add(user_id);
  }

  ChatRoomViewModel.fromJson(Map json){
    this.id = json["id"];
    this.participants = json["participants"].cast<int>();
    this.group = json["group"];
  }
}

class ChatMessageViewModel{
  int id;
  int chat_id;
  int sender_id;
  String message;
  int time;

  ChatMessageViewModel(this.id, this.chat_id, this.sender_id, this.message, this.time,);

  ChatMessageViewModel.fromJson(Map json){
    this.id = json["id"];
    this.chat_id = json["chat_id"];
    this.sender_id = json["sender_id"];
    this.message = json["message"];
    this.time = json["time"];
  }

}