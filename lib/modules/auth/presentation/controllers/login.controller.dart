import 'package:basigo_dirt/core/widgets/app_snackbar.dart';
import 'package:basigo_dirt/core/widgets/loader.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/login.usecase.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/incidents_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCTRL = TextEditingController();
  final passwordCTRL = TextEditingController();

  Rx<bool> showPassword = false.obs;

  LoginUseCase get loginUsecase => LoginUseCase();

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      Loader.show('Verifying...');
      final response = await loginUsecase(
        (
          email: emailCTRL.text.trim(),
          password: passwordCTRL.text.trim(),
        ),
      );
      Loader.dismiss();

      response.fold((ex) {
        AppSnackBar.show(ex.message, status: SnackBarStatus.error);
      }, (data) {
        reset();
        Get.offNamed(IncidentsOverviewPage.route);

        AppSnackBar.show('Welcome ${data.name}');
      });
    }
  }

  void reset() {
    emailCTRL.clear();
    passwordCTRL.clear();
  }
}
