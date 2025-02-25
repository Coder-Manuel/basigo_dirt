import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarStatus {
  success,
  info,
  error,
}

extension SnackBarStatusExt on SnackBarStatus {
  String get title => name.capitalizeFirst ?? name;
  Color get backgroundColor {
    switch (this) {
      case SnackBarStatus.success:
        return const Color(0xff2FB5B0);
      case SnackBarStatus.info:
        return const Color.fromARGB(255, 205, 188, 6);
      case SnackBarStatus.error:
        return const Color(0xFF940000);
    }
  }

  IconData get icon {
    switch (this) {
      case SnackBarStatus.success:
        return Icons.check_circle_outline;
      case SnackBarStatus.info:
        return Icons.info_outline_rounded;
      case SnackBarStatus.error:
        return Icons.error_outline;
    }
  }
}

class AppSnackBar {
  static void show(
    String message, {
    SnackBarStatus status = SnackBarStatus.success,
    Color color = const Color(0xff2FB5B0),
  }) {
    Get.snackbar(
      status.title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: status.backgroundColor,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      icon: Icon(
        status.icon,
        color: Colors.white,
      ),
    );
  }
}
