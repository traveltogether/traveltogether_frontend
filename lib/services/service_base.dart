import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ServiceBase {
  HttpClient client = new HttpClient();
  final String baseUrl = "api.traveltogether.eu";
  final String version = "/v1/";

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
        .then((HttpClientRequest request) {
      request.headers.add("X-Auth-Key", "54c8e0e0-d82c-4f50-92f8-834b8c013617");
      return request.close();
    }).then((HttpClientResponse response) {
      return handleResponse(response);
    });
  }

  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> jsonBody) {
    return client
        .postUrl(Uri.https('$baseUrl', '$version$url'))
        .then((HttpClientRequest request) {
      request.headers.add("X-Auth-Key", "54c8e0e0-d82c-4f50-92f8-834b8c013617");
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

  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> jsonBody) {
    return client
        .putUrl(Uri.https('$baseUrl', '$version$url'))
        .then((HttpClientRequest request) {
      request.headers.add("X-Auth-Key", "54c8e0e0-d82c-4f50-92f8-834b8c013617");
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
        .then((HttpClientRequest request) {
      request.headers.add("X-Auth-Key", "54c8e0e0-d82c-4f50-92f8-834b8c013617");
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
