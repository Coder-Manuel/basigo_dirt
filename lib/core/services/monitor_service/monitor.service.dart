import 'package:basigo_dirt/core/utils/logger.util.dart';
import 'package:basigo_dirt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class MonitorService {
  /// Initializes the listener to handle all exceptions/errors
  ///
  /// It also sends bug report to the server for analysis.
  static Future<void> init() async {
    // * Initialize Firebase.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (FlutterErrorDetails details) async {
      // * Doing this to silence the error by cache_network_image library
      if (details.library != 'image resource service') {
        FlutterError.presentError(details);

        FlutterError.resetErrorCount();

        // * Report the ERROR to any monitoring tools
      }
    };

    Logger.log('Moniter Service Initialized');
  }

  /// This method throws a Flutter Error that is show on the console with the
  /// context and StackTrace
  ///
  /// The error is also reported to the server for future analytics and reports.
  ///
  /// >* _`@param:`_ [Object] ex => The exception/error thrown.
  ///
  /// >* _`@param:`_ [StackTrace?] stack => The stacktrace of the exception/error.
  ///
  /// >* _`@param:`_ [String] context => The context where the exception is thrown.
  /// It can be a [Class name], [Module name], [Method name], [File name] e.t.c
  ///
  /// >* _`@param:`_ [String] description => A short but elaborate description of
  /// what activity/action was being done when the exception was thrown. Use
  /// [while] as the 1st word. `Example`: [while fetching user data] or
  /// [while uploading user passport].

  static void report({
    required Object ex,
    required String library,
    StackTrace? stack,
    String? description,
  }) {
    // * This will trigger a bug report to monitoring tools
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: ex,
        stack: stack,
        library: library,
        context: description != null ? ErrorDescription(description) : null,
      ),
    );
  }
}
