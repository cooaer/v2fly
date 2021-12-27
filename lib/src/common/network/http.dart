import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:v2fly/src/common/network/response.dart';

import 'cookie.dart';

final dio = Dio()
  ..options = BaseOptions(connectTimeout: 30 * 1000, receiveTimeout: 30 * 1000)
  ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true))
  ..interceptors.add(CookieManager(cookieJar))
  ..interceptors.add(AddHeaderInterceptor());

Future<NetworkResponse<T?>> doHttpGet<T>(String url,
    {Map<String, dynamic>? headers}) async {
  var contentType = headers?.remove('Content-Type');
  var response = await dio.get<T>(url,
      options: Options(headers: headers, contentType: contentType));
  return convertToNetworkResponse<T>(response);
}

Future<NetworkResponse<T?>> doHttpPost<T>(
    String url, dynamic data, Map<String, dynamic> headers) async {
  var contentType = headers.remove('Content-Type');
  var response = await dio.post<T>(url,
      data: data, options: Options(headers: headers, contentType: contentType));
  return convertToNetworkResponse<T>(response);
}

NetworkResponse<T?> convertToNetworkResponse<T>(Response<T> response) {
  final code = response.statusCode ?? HttpStatusCode.unknown;
  final message = response.statusMessage;
  return NetworkResponse(code, message, response.data as T);
}

class AddHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
