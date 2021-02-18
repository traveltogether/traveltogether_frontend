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

  Future<Map<String, dynamic>> add(UserWriteViewModel user) async {
    var json = mapUserToJson(user);
    return await post("auth/register", json);
  }

  Future<Map<String, dynamic>> changeUserMail(String newMail) async {
    return put("auth/mail", {"mail": newMail});
  }
}