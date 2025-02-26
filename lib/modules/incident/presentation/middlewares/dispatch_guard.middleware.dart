import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/current_user.usecase.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/driver_incidents_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispatchGuardMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    final userUsecase = CurrentUserUseCase();

    if (userUsecase.user?.role.isDriver == true) {
      return RouteSettings(name: DriverIncidentsPage.route);
    }

    return null;
  }
}
