/*import 'package:web_socket_channel/io.dart';

main() async {
  var channel = await IOWebSocketChannel.connect("ws://<YOUR_SERVER_IP>:<YOUR_PORT>");

  channel.stream.listen((message) {
    channel.sink.add("received!");
    channel.close(status.goingAway);
  }, onDone: () => print("Stream closed"));
}

class ChatMessageViewModel{
  int id;
  int chat_id;
  int sender_id;
  String message;

}*/