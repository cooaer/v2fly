class NetworkResponse<T> {
  final int code;
  final String? message;
  final T? data;

  NetworkResponse(this.code, this.message, this.data);

  bool get isSuccessful => code >= 200 && code < 300;
}


class HttpStatusCode{
  static const unknown = -1;
}