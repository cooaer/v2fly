import 'dart:ffi';

import 'http.dart';

class HttpMakerParams {
  static const url = 'url';
  static const method = 'method';
  static const data = 'data';
  static const headers = "headers";
  static const methodGet = 'get';
  static const methodPost = 'post';
}

typedef HttpMaker<T> = T? Function(Map<String, dynamic> params);

Future<T?> doHttpMaker<T extends String>(Map<String, dynamic> params) {
  var url = params.remove(HttpMakerParams.url);
  var method = params.remove(HttpMakerParams.method);
  var data = params.remove(HttpMakerParams.data);
  var headers = params.remove(HttpMakerParams.headers);
  switch (method) {
    case HttpMakerParams.methodGet:
      return doHttpGet<T>(url);
    case HttpMakerParams.methodPost:
      return doHttpPost<T>(url, data, headers);
  }
  return Future.error(Void);
}
