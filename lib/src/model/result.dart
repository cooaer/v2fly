class Error {
  //网络异常
  static const codeNetworkError = 3;
  //无数据
  static const codeNoResponse = 1;
  //数据解析异常
  static const codeDecodingError = 2;
  //数据无效
  static const codeInvalid = 4;

  final int code;

  Error(this.code);
}

class ResponseResult<T> {
  final T? data;
  final Error? error;

  ResponseResult(this.data, this.error);

  ResponseResult.data(T data) : this(data, null);

  ResponseResult.error(Error error) : this(null, error);

}
