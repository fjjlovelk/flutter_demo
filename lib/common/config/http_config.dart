class HttpConfig {
  static String baseUrl = 'http://172.20.10.6:4396';
  // static String baseUrl = 'http://192.168.3.25:8000';
  static Duration connectTimeout = const Duration(seconds: 10);
  static Duration receiveTimeout = const Duration(seconds: 10);
}
