import 'package:basigo_dirt/modules/auth/presentation/pages/login.page.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  Future<void> goToHome() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => Get.offNamed(LoginPage.route),
    );
  }
}
