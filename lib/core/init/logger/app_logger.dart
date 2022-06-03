import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._init();

  static AppLogger get instance => _instance;

  late Logger _logger;

  AppLogger._init() {
    _logger = Logger();
  }

  debugLog(String message) {
    _logger.d(message);
  }
}
