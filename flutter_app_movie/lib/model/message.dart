import 'package:flutterappmovie/const/image.dart';
import 'package:flutterappmovie/model/user.dart';

final User currentUser = User(0, "Naruto", ImagePath.imgNaruto);
final User sasuke = User(1, "Sasuke", ImagePath.imgSasuke);
final User hinata = User(2, "Hinata", ImagePath.imgHinata);
final User minato = User(3, "Minato", ImagePath.imgMinato);
final User itachi = User(4, "Itachi", ImagePath.imgItachi);

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({this.sender, this.time, this.text, this.isLiked, this.unread});

}

final List<User> favourite = [hinata, sasuke, minato];

List<Message> chats = [
  Message(
      sender: hinata,
      time: "5:30 PM",
      text: "Hey, what did you do today?",
      isLiked: false,
      unread: true
  ),
  Message(
      sender: sasuke,
      time: "15:30 PM",
      text: "Hey, what did you do today?",
      isLiked: true,
      unread: true
  ),
  Message(
      sender: minato,
      time: "1:30 PM",
      text: "Hey, what did you do today?",
      isLiked: false,
      unread: true
  ),
  Message(
      sender: itachi,
      time: "5:20 PM",
      text: "Hey, what did you do today?",
      isLiked: false,
      unread: true
  ),
];