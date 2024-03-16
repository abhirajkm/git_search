import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'api_client.dart';
import 'api_exception.dart';
import 'api_methods.dart';

class ApiRequest {


  static send({
    ApiMethod? method,
    String? enableTempUrl,
    bool getRawResponse = false,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    required String route,
    Map<String, dynamic>? queries,
  }) async {
    final api = ApiClient();

    late Response response;

    if (queries != null && queries.isNotEmpty) {
      queries.forEach((key, value) {
        if (value != null) {
          if (route.contains("?")) {
            route += "&$key=$value";
          } else {
            route += "?$key=$value";
          }
        }
      });
    }

    try {
      Uri uri = Uri.parse(api.url(route));
      if (method == ApiMethod.GET) {
        response = await api.client().get(uri);
      } else if (method == ApiMethod.POST) {
        response = await api.client().post(uri, body: json.encode(body));
      } else if (method == ApiMethod.DELETE) {
        await api.client().delete(uri);
      } else if (method == ApiMethod.PUT) {
        response = await api.client().put(uri, body: json.encode(body));
      }

      switch (response.statusCode) {
        case 401:
          final body = response.body;
          if (response.body != null) {
            final json = jsonDecode(response.body);


          }


          throw UnauthorisedException();

        case 402:
          throw UnauthorisedException();
        case 400:
          final body = jsonDecode(response.body);

        // case 404:
        //   throw new FetchDataException();
      }

      final responseBody = json.decode(response.body);
      if (response.body != null) {
        final body = jsonDecode(response.body);
        if (getRawResponse) {
          return body["url"];
        }
        return json.decode(response.body);
      }
      return responseBody;
    } on SocketException {
      print("Socket exception");
    }
  }
}
