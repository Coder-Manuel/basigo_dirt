import 'package:basigo_dirt/core/widgets/app_snackbar.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/current_user.usecase.dart';
import 'package:basigo_dirt/modules/auth/presentation/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuardMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final userUsecase = CurrentUserUseCase();

    if (userUsecase.user == null) {
      AppSnackBar.show(
        "Kindly login to proceed",
        status: SnackBarStatus.info,
      );

      return RouteSettings(name: LoginPage.route);
    }

    return null;
  }
}
