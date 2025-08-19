class ResponseWrapper<T> {
  final T? data;
  final bool success;
  final String? message;
  final int? statusCode;

  ResponseWrapper({
    this.data,
    this.success = true,
    this.message,
    this.statusCode,
  });

  factory ResponseWrapper.error({String? message, int? statusCode}) {
    return ResponseWrapper(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }

  bool isSuccess() {
    return statusCode != null && statusCode! >= 200 && statusCode! < 300;
  }

  bool isUnauthorized() {
    return statusCode == 401;
  }

  bool isNotFound() {
    return statusCode == 404;
  }
}
