import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:html/parser.dart';
import 'package:v2fly/src/common/network/response.dart';
import 'package:v2fly/src/common/path.dart';
import 'package:v2fly/src/model/html.dart';
import 'package:v2fly/src/model/result.dart';

class V2exHttpMaker {
  static V2exHttpMaker? _instance;

  V2exHttpMaker._();

  factory V2exHttpMaker.getInstance() => _getInstance();

  static V2exHttpMaker _getInstance() {
    _instance ??= V2exHttpMaker._();
    return _instance!;
  }

  Dio? _dio;

  Future<ResponseResult<T>> htmlGet<T extends BaseModel>(
      ModelCreator<T> createModel, String url,
      {Map<String, String>? headers}) async {
    createDioIfNotExists();

    var contentType = headers?.remove(Headers.contentTypeHeader);
    var response = await _dio!.get<String>(url,
        options: Options(headers: headers, contentType: contentType));

    final statusCode = response.statusCode;
    if (statusCode == null || statusCode != HttpStatus.ok) {
      //网络异常
      final error = Error(Error.codeNetworkError);
      return ResponseResult.error(error);
    } else {
      //请求成功
      if (response.data == null) {
        return ResponseResult.error(Error(Error.codeNoResponse));
      }
      final dom = parse(response.data);
      final htmlBody = dom.body;
      if (htmlBody == null) {
        return ResponseResult.error(Error(Error.codeDecodingError));
      }
      final data = createModel(htmlBody);
      if (!data.isValid()) {
        return ResponseResult.error(Error(Error.codeInvalid));
      }
      return ResponseResult.data(data);
    }
  }

  Future<ResponseResult<T>> htmlPost<T extends BaseModel>() async {
    throw UnimplementedError("");
  }

  void createDioIfNotExists() async {
    if (_dio != null) {
      return;
    }

    final cookiePath = AppPath.instance.tempCookieDirPath;
    final cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    _dio = Dio()
      ..options =
          BaseOptions(connectTimeout: 10 * 1000, receiveTimeout: 10 * 1000)
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true))
      ..interceptors.add(CookieManager(cookieJar));
  }

  NetworkResponse<T?> convertToNetworkResponse<T>(Response<T> response) {
    final code = response.statusCode ?? HttpStatusCode.unknown;
    final message = response.statusMessage;
    return NetworkResponse(code, message, response.data as T);
  }

  bool isResponseSuccessful(Response response) {
    final statusCode = response.statusCode;
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }
}
