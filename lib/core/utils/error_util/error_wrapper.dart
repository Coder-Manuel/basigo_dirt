import 'dart:async';

import 'package:basigo_dirt/core/services/monitor_service/monitor.service.dart';

/// Error Wrapper that automatically handles the errors behind the scenes.
///
/// > * _@wrap_ => Wrap callbacks to auto handle errors.
///
class ErrorWrapper {
  /// Wrapper for async methods or [Future] methods. Returns a [Future<T> or T].
  ///
  /// > * _@param: (required)_ __[Function()]__
  ///
  /// > * _@param: (required)_ __[String]__ library => This is the library/Module from where the function is called.
  ///
  /// > * _@param: (required)_ __[String]__ description => This is the description of the method's functionality, should be very simple. Use keyword `while`
  /// then followed with the description. `E.g while converting string to int`.
  ///
  /// Example:
  /// ```
  /// final status = ErrorWrapper.wrap<int>(
  ///          () => testFunction(),
  ///          context: 'Component Test',
  ///          description: 'while testing component',
  ///        );
  /// ```
  @pragma('vm:notify-debugger-on-exception')
  static FutureOr<T?> wrap<T>(
    FutureOr<T> Function() callback, {
    required String library,
    required String description,
    T? Function(Object error)? onError,
  }) {
    try {
      return Future.sync(callback);
    } catch (error, stack) {
      // * This will dump the error to the console and also report it for monitoring.
      MonitorService.report(
        ex: error,
        library: library,
        description: description,
        stack: stack,
      );

      if (onError != null) return onError(error);
      return null;
    }
  }
}
