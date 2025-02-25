import 'package:basigo_dirt/modules/auth/domain/usecases/current_user.usecase.dart';
import 'package:basigo_dirt/modules/auth/presentation/pages/login.page.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/driver_incidents_page.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  CurrentUserUseCase get userUseCase => CurrentUserUseCase();

  Future<void> goToHome() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        if (userUseCase.user == null) {
          return Get.offNamed(LoginPage.route);
        }

        return Get.offNamed(DriverIncidentsPage.route);
      },
    );
  }
}
