import 'package:basigo_dirt/modules/incident/presentation/pages/driver_incidents_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailCTRL = TextEditingController();
  final passwordCTRL = TextEditingController();

  Rx<bool> showPassword = false.obs;

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  Future<void> login() async {
    Get.offNamed(DriverIncidentsPage.route);
  }
}
