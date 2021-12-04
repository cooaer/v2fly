import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'cookie.dart';

final dio = Dio()
  ..options = BaseOptions(connectTimeout: 30 * 1000, receiveTimeout: 30 * 1000)
  ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true))
  ..interceptors.add(CookieManager(cookieJar))
  ..interceptors.add(AddHeaderInterceptor());

Future<T?> doHttpGet<T>(String url) async {
  var response = await dio.get<T>(url);
  return response.data;
}

Future<T?> doHttpPost<T>(
    String url, dynamic data, Map<String, dynamic> headers) async {
  var contentType = headers.remove('Content-Type');
  var response = await dio.post<T>(url,
      data: data, options: Options(headers: headers, contentType: contentType));
  return response.data;
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
