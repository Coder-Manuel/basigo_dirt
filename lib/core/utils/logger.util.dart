import 'dart:developer' as developer;

/// Utility class for logging out messages
class Logger {
  /// Logs out message but must be used with DartVM
  static void log(String message) {
    developer.log(message, name: 'BASIGO_DIRT');
  }

  /// Logs out error message but must be used with DartVM
  static void error(String message) {
    developer.log('', name: 'BASIGO_DRIT', level: 900, error: message);
  }
}
