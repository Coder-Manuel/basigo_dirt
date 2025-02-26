import 'dart:async';

import 'package:basigo_dirt/core/widgets/app_snackbar.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/current_user.usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/usecases/get_incidents_stream.usercase.dart';
import 'package:get/get.dart';

class DriverIncidentsController extends GetxController with StateMixin<bool> {
  GetIncidentsStreamUseCase get incidentsStreamUseCase =>
      GetIncidentsStreamUseCase();
  CurrentUserUseCase get userUseCase => CurrentUserUseCase();
  RxList<Incident> incidents = <Incident>[].obs;

  StreamSubscription<List<Incident>>? _incidentSubscription;

  Future<void> getIncidents() async {
    if (_incidentSubscription == null) {
      await Future.delayed(const Duration(milliseconds: 50));
      change(false, status: RxStatus.loading());
    }
    final response = incidentsStreamUseCase.call(false);
    response.fold((ex) {
      AppSnackBar.show(ex.message, status: SnackBarStatus.info);
    }, (stream) {
      _incidentSubscription = stream.listen((data) {
        _addItems(data);

        change(
          true,
          status: incidents.isEmpty ? RxStatus.empty() : RxStatus.success(),
        );
      });
    });
  }

  void _addItems(List<Incident> items) {
    incidents.value = items;
  }

  @override
  void onClose() {
    _incidentSubscription?.cancel();
    super.onClose();
  }
}
