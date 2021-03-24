import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ServiceBase {
  HttpClient client = new HttpClient();
  final String baseUrl = "api.traveltogether.eu";
  final String version = "/v1/";

  Future<void> setAuthKey(Future<Map<String, dynamic>> json) async {
    var authKey = await json.then((value) => value["session_key"].toString());
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("authKey", authKey);
  }

  Future<String> getAuthKey() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("authKey");
  }

  Future<Map<String, dynamic>> handleResponse(HttpClientResponse response) {
    final completer = Completer<Map<String, dynamic>>();
    final contents = StringBuffer();

    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(jsonDecode(contents.toString())));
    return completer.future;
  }

  Future<Map<String, dynamic>> get(String url,
      [Map<String, String> queryParams]) async {
    return client
        .getUrl(Uri.https('$baseUrl', '$version$url', queryParams))
        .then((HttpClientRequest request) async {
      var authKey = await getAuthKey();
      request.headers.add("X-Auth-Key", authKey);
      return request.close();
    }).then((HttpClientResponse response) {
      return handleResponse(response);
    });
  }

  Future<Map<String, dynamic>> post(String url,
      [Map<String, dynamic> jsonBody, bool login = false]) async {
    return client
        .postUrl(Uri.https('$baseUrl', '$version$url'))
        .then((HttpClientRequest request) async {
      if (!login) {
        var authKey = await getAuthKey();
        request.headers.add("X-Auth-Key", authKey);
      }
      if (jsonBody != null) {
        request.headers.add('content-type', 'application/json');
        request.add(utf8.encode(json.encode(jsonBody)));
      }
      return request.close();
    }).then((HttpClientResponse response) async {
      if (response.statusCode == 200) {
        if (login) {
          await setAuthKey(handleResponse(response));
        }
        return {"error": null};
      } else {
        return handleResponse(response);
      }
    });
  }

  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> jsonBody) {
    return client
        .putUrl(Uri.https('$baseUrl', '$version$url'))
        .then((HttpClientRequest request) async {
      var authKey = await getAuthKey();
      request.headers.add("X-Auth-Key", authKey);
      request.headers.add('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonBody)));
      return request.close();
    }).then((HttpClientResponse response) {
      if (response.statusCode == 200) {
        return {"error": null};
      } else {
        return handleResponse(response);
      }
    });
  }

  Future<Map<String, dynamic>> delete(String url) {
    return client
        .deleteUrl(Uri.https('$baseUrl', '$version$url'))
        .then((HttpClientRequest request) async {
      var authKey = await getAuthKey();
      request.headers.add("X-Auth-Key", authKey);
      return request.close();
    }).then((HttpClientResponse response) {
      if (response.statusCode == 200) {
        return {"error": null};
      } else {
        return handleResponse(response);
      }
    });
  }
}
