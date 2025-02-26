import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/widgets/app_snackbar.dart';
import 'package:basigo_dirt/core/widgets/loader.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/current_user.usecase.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident_analysis.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/usecases/get_incident_analysis.usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/usecases/update_incident.usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentOverviewController extends GetxController with StateMixin<bool> {
  final commentCTRL = TextEditingController();
  Rx<IncidentStatus?> incidentStatus = Rx(null);
  Rx<IncidentAnalysisFilter> analysisFilter = Rx(IncidentAnalysisFilter.today);
  Rx<IncidentAnalysis?> analysis = Rx(null);
  CurrentUserUseCase get userUseCase => CurrentUserUseCase();
  UpdateIncidentUseCase get updateIncidentUseCase => UpdateIncidentUseCase();
  GetIncidentAnalysisUseCase get getIncidentAnalysisUseCase =>
      GetIncidentAnalysisUseCase();

  Future<void> getIncidentAnalysis() async {
    await Future.delayed(Duration.zero);
    change(false, status: RxStatus.loading());
    final response = await getIncidentAnalysisUseCase.call(
      analysisFilter.value,
    );
    change(false, status: RxStatus.success());
    response.fold((ex) {
      AppSnackBar.show(ex.message, status: SnackBarStatus.error);
    }, (data) {
      analysis.value = data;
    });
  }

  Future<void> updateIncident(Incident incident) async {
    Loader.show('Updating...');
    final response = await updateIncidentUseCase.call(
      IncidentModel.fromEntity(incident).copyWith(
        dispatch: userUseCase.user,
        status: incidentStatus.value,
        dispatchComments: commentCTRL.text.trim(),
      ),
    );
    Loader.dismiss();

    response.fold((ex) {
      AppSnackBar.show(ex.message, status: SnackBarStatus.error);
    }, (_) {
      Get.back();
      AppSnackBar.show('Incident updated');
    });
  }

  Future<void> updateDisplayItems(Incident incident) async {
    incidentStatus.value = incident.status;
    commentCTRL.text = incident.dispatchComments ?? '';
  }
}
