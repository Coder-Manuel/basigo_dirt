import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // AuthService authService = Get.find<AuthService>();

    // if (!authService.isLoggedIn || authService.user == null) {
    //   AppSnackBar.show(
    //     "Kindly login to proceed",
    //     status: SnackBarStatus.info,
    //   );

    //   return const RouteSettings(name: LoginPage.name);
    // }

    return null;
  }
}
