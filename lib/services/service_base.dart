import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ServiceBase {
  HttpClient client = new HttpClient();
  final String baseUrl = "https://api.traveltogether.eu/v1/";

  Future<Map<String, dynamic>> getHttpBody(String url) async {
    final completer = Completer<Map<String, dynamic>>();
    final contents = StringBuffer();

    return client
        .getUrl(Uri.parse('$baseUrl$url'))
        .then((HttpClientRequest request) {
      request.headers.add("X-Auth-Key", "54c8e0e0-d82c-4f50-92f8-834b8c013617");
      return request.close();
    }).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((data) {
        contents.write(data);
      }, onDone: () => completer.complete(jsonDecode(contents.toString())));
      return completer.future;
    });
  }
}
