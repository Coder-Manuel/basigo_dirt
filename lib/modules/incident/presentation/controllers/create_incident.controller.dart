import 'dart:io';

import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/utils/io_util/io_util.dart';
import 'package:basigo_dirt/core/utils/location_util/location.util.dart';
import 'package:basigo_dirt/core/widgets/app_snackbar.dart';
import 'package:basigo_dirt/core/widgets/loader.dart';
import 'package:basigo_dirt/modules/auth/domain/usecases/current_user.usecase.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/location.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/usecases/create_incident.usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';

class CreateIncidentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleCTRL = TextEditingController();
  final locationCTRL = TextEditingController();
  final descriptionCTRL = TextEditingController();
  Rx<IncidentSeverity?> severity = Rx(null);
  Rx<Location?> location = Rx(null);
  Rx<File?> media = Rx(null);

  CurrentUserUseCase get userUsecase => CurrentUserUseCase();
  CreateIncidentUseCase get createIncidentUsecase => CreateIncidentUseCase();

  Future<void> getImage() async {
    final file = await IOUtil.getImageModal();
    if (file != null) media.value = file.file;
  }

  Future<void> getCurrentLocation() async {
    final position = await LocationUtil.getCurrentPosition();
    if (position != null) {
      location.value = Location(
        address: position.$2 ?? 'Address Unavailable',
        lat: position.$1.latitude,
        long: position.$1.longitude,
      );
      locationCTRL.text = location.value?.address ?? '';
    }
  }

  Future<void> reportIncident() async {
    if (formKey.currentState?.validate() == true) {
      Loader.show('Reporting Incident...');
      final response = await createIncidentUsecase(
        IncidentModel(
          title: titleCTRL.text.trim(),
          severity: severity.value!,
          description: descriptionCTRL.text.trim(),
          location: location.value,
          imageUrl: media.value?.path,
          driver: userUsecase.user!,
        ),
      );
      Loader.dismiss();

      response.fold((ex) {
        AppSnackBar.show(ex.message, status: SnackBarStatus.error);
      }, (_) {
        reset();
        Get.back();
        AppSnackBar.show('Incident Reported Succesfully');
      });
    }
  }

  void onPrediction(Prediction prediction) {
    locationCTRL.text = prediction.description ?? '';
    location.value = Location(
      address: prediction.description ?? '',
      lat: double.tryParse(prediction.lat ?? '') ?? 0,
      long: double.tryParse(prediction.lng ?? '') ?? 0,
    );
  }

  void reset() {
    titleCTRL.clear();
    severity.value = null;
    descriptionCTRL.clear();
    locationCTRL.clear();
    location.value = null;
    media.value = null;
  }

  @override
  void onInit() async {
    super.onInit();
    await getCurrentLocation();
  }
}
