import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBar {
  static void show(
    String message, {
    bool isError = false,
    Color color = const Color(0xff2FB5B0),
  }) {
    Get.snackbar(
      isError ? "Error" : "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? const Color(0xFF940000) : color,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
      ),
    );
  }
}
