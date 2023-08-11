class HttpErrorModel implements Exception {
  int code = -1;
  String message = '';

  HttpErrorModel({required this.code, required this.message});

  @override
  String toString() {
    return "Exception: code：$code, message：$message";
  }
}
