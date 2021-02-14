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
      request.headers.add("X-Auth-Key", "8c1e32b2-0faa-4d54-9e00-ddb64b2c3b57");
      return request.close();
    }).then((HttpClientResponse response) {
      return handleResponse(response);
    });
  }

  Future<Map<String, dynamic>> post(
      String url, [Map<String, dynamic> jsonBody]) {
    return client
        .postUrl(Uri.https('$baseUrl', '$version$url'))
        .then((HttpClientRequest request) {
      request.headers.add("X-Auth-Key", "8c1e32b2-0faa-4d54-9e00-ddb64b2c3b57");
      if (jsonBody != null) {
        request.headers.add('content-type', 'application/json');
        request.add(utf8.encode(json.encode(jsonBody)));
      }
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
      request.headers.add("X-Auth-Key", "8c1e32b2-0faa-4d54-9e00-ddb64b2c3b57");
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
      request.headers.add("X-Auth-Key", "8c1e32b2-0faa-4d54-9e00-ddb64b2c3b57");
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
