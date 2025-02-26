import 'package:basigo_dirt/core/widgets/app_snackbar.dart';
import 'package:basigo_dirt/core/widgets/loader.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/logout.usecase.dart';
import 'package:basigo_dirt/modules/auth/presentation/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final logoutUseCase = LogoutUseCase();
        Loader.show('Clearing Info...');
        final response = await logoutUseCase(null);
        Loader.dismiss();
        response.fold((ex) {
          AppSnackBar.show(ex.message, status: SnackBarStatus.error);
        }, (_) {
          Get.offAllNamed(LoginPage.route);
        });
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 25),
        child: Icon(Icons.power_settings_new_rounded),
      ),
    );
  }
}
