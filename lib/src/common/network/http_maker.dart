import 'dart:ffi';

import 'package:v2fly/src/common/network/response.dart';

import 'http.dart';

class HttpMakerParams {
  static const url = 'url';
  static const method = 'method';
  static const data = 'data';
  static const headers = "headers";
  static const methodGet = 'get';
  static const methodPost = 'post';
}

typedef HttpMaker<T> = Future<NetworkResponse<T?>> Function(
    Map<String, dynamic> params);

Future<NetworkResponse<T?>> doHttpMaker<T>(Map<String, dynamic> params) {
  var url = params[HttpMakerParams.url];
  var method = params[HttpMakerParams.method];
  var data = params[HttpMakerParams.data];
  var headers = params[HttpMakerParams.headers];
  switch (method) {
    case HttpMakerParams.methodGet:
      return doHttpGet<T>(url, headers: headers);
    case HttpMakerParams.methodPost:
      return doHttpPost<T>(url, data, headers);
  }
  return Future.error(Void);
}
