import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import '../api/api_interceptor.dart';

class ApiClient {
  String baseUrl = "https://api.github.com/users/";

  ApiClient();

  http.Client client() {
    http.Client client =  InterceptedClient
        .build(interceptors: [ApiInterceptor()]);
    return client;
  }

  String url(String? route) {
    return "$baseUrl$route";
  }
}
