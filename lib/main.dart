import 'dart:async';

import 'package:basigo_dirt/basigo_dirt.dart';
import 'package:basigo_dirt/core/initializer.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () async {
      // * Init core services/utils
      await Initializer.init();

      runApp(const BasigoDirt());
    },
    (Object ex, StackTrace stack) => FlutterError.reportError(
      FlutterErrorDetails(
        exception: ex,
        stack: stack,
        library: 'Main ZoneGuard',
      ),
    ),
  );
}
