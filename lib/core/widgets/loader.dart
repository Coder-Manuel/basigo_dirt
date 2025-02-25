import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  static void show([
    String message = "Loading...",
    bool isDismissible = false,
  ]) {
    EasyLoading.instance
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskColor = Colors.black.withOpacity(0.5)
      ..textColor = Colors.black
      ..radius = 20
      ..maskType = EasyLoadingMaskType.custom
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..lineWidth = 2
      ..indicatorSize = 45;
    EasyLoading.show(status: message);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
