class ChatRoomViewModel {
  int id;
  List<int> participants;
  bool group = false;

  ChatRoomViewModel(this.id, this.participants, this.group);

  void addUser(int userId) {
    participants.add(userId);
  }

  ChatRoomViewModel.fromJson(Map json) {
    this.id = json["id"];
    this.participants = json["participants"].cast<int>();
    this.group = json["group"];
  }
}

class ChatMessageViewModel {
  int id;
  int chatId;
  int senderId;
  String message;
  int time;

  ChatMessageViewModel(
    this.id,
    this.chatId,
    this.senderId,
    this.message,
    this.time,
  );

  ChatMessageViewModel.fromJson(Map json) {
    this.id = json["id"];
    this.chatId = json["chat_id"];
    this.senderId = json["sender_id"];
    this.message = json["message"];
    this.time = json["time"];
  }
}
