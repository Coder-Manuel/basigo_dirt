import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Loader {
  static void show([
    String message = "Loading...",
    bool isDismissible = false,
  ]) {
    EasyLoading.instance
      ..backgroundColor = Colors.white
      ..indicatorColor = Get.theme.primaryColor
      ..maskColor = Get.theme.primaryColor.withOpacity(0.4)
      ..textColor = Get.theme.primaryColor
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
