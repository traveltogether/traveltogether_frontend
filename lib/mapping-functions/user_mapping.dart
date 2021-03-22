import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_write_view_model.dart';

UserReadViewModel mapUserToReadViewModel(Map<String, dynamic> json) {
  var user = new UserReadViewModel();

  user.id = json["id"];
  user.username = json["username"];
  user.firstName = json["first_name"];
  user.mail = json["mail"];
  user.profileImage = json["profile_image"];
  user.disabilities = json["disabilities"];
  return user;
}

Map<String, dynamic> mapUserToJson(UserWriteViewModel user) {
  var json = new Map<String, dynamic>();

  json["username"] = user.username;
  json["mail"] = user.mail;
  json["password"] = user.password;
  json["first_name"] = user.firstName;
  json["profile_image"] = user.profileImage;
  json["disabilities"] = user.disabilities;

  return json;
}
