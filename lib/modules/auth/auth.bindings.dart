import 'package:basigo_dirt/modules/auth/presentation/controllers/login.controller.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/splash_page.controller.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
