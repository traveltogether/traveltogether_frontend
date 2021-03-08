import 'package:traveltogether_frontend/mapping-functions/user_mapping.dart';
import 'package:traveltogether_frontend/services/service_base.dart';
import 'package:traveltogether_frontend/view-models/user_read_view_model.dart';
import 'package:traveltogether_frontend/view-models/user_write_view_model.dart';

class UserService extends ServiceBase {
  final url = "users";

  Future<UserReadViewModel> getUser(int id) async {
    var user = await get('$url/${id.toString()}')
        .then((json) => mapUserToReadViewModel(json));
    return user;
  }

  Future<UserReadViewModel> getCurrentUser() async {
    var user = await get('$url/me')
        .then((json) => mapUserToReadViewModel(json));
    return user;
  }

  Future<Map<String, dynamic>> addUser(UserWriteViewModel user) async {
    var json = mapUserToJson(user);
    return await post("auth/register", json);
  }

  Future<Map<String, dynamic>> login(String usernameOrMail, String password) async {
    return await post("auth/login",  {"username_or_mail": usernameOrMail, "password": password});
  }

  Future<Map<String, dynamic>> changeMail(String newMail) async {
    return put("auth/mail", {"mail": newMail});
  }

  Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword) async {
    return put("auth/password", {"old_password": oldPassword, "new_password": newPassword});
  }

  Future<Map<String, dynamic>> changeDisability(int id, String disability) async {
    return put("users/${id.toString()}/disabilities", {"disabilities": disability});
  }

  Future<Map<String, dynamic>> changeProfilePic(int id, String profilePic) async {
    return put("users/${id.toString()}/profile-image", {"profile_image": profilePic});
  }

  Future<Map<String, dynamic>> changeUsername(int id, String username) async {
    return put("users/${id.toString()}/username", {"username": username});
  }
}