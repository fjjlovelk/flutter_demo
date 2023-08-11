class Logger {
  static void write(String text, {bool isError = false}) {
    print('Logger');
    Future.microtask(() => print('** $text. isError: [$isError]'));
  }
}
