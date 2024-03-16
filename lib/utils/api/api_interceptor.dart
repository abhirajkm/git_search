import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      if (data.headers['content-type'] != 'multipart/form-data') {
        data.headers['content-type'] = 'application/json';
      }
    } catch (e) {
      print(e);
    }

    log("------->Request Start\n${data.method}: ${data.baseUrl} \nHeaders: ${data.headers}\nBody: \n${data.body}\n<----------Request End");

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    log(
      "------->Response Start\n${data.method}${data.statusCode}: ${data.url} \nBody: \n${data.body}\n<----------Response End",
    );

    return data;
  }
}
