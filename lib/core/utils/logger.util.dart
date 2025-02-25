import 'dart:developer' as developer;

/// Utility class for logging out messages
class Logger {
  static const String _app = 'BASIGO_DIRT';

  /// Logs out message but must be used with DartVM
  static void log(String message) {
    developer.log(message, name: _app);
  }

  /// Logs out error message but must be used with DartVM
  static void error(String message, [Object? error]) {
    developer.log(message, name: _app, level: 1200, error: error);
  }
}
