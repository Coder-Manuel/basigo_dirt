import 'dart:io';

import 'package:basigo_dirt/config/env/env.dart';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:basigo_dirt/core/widgets/form_label.dart';
import 'package:basigo_dirt/core/widgets/form_validator.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/create_incident.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class CreateIncidentPage extends GetView<CreateIncidentController> {
  static String route = '/create_incident_page';

  const CreateIncidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormLabel(label: 'Title'),
                Text(
                  'Small description of the incident.',
                  style: Get.textTheme.bodyMedium,
                ),
                10.0.h,
                TextFormField(
                  controller: controller.titleCTRL,
                  maxLength: 25,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (v) {
                    if (v?.isEmpty ?? true) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'E.g Brake Failure',
                  ),
                ),
                20.h,
                const FormLabel(label: 'Severity'),
                Text(
                  'What is the level of severity?',
                  style: Get.textTheme.bodyMedium,
                ),
                5.0.h,
                FormValidator<IncidentSeverity>(
                  validator: (v) {
                    if (controller.severity.value == null) {
                      return 'Please select severity level';
                    }
                    return null;
                  },
                  child: Row(
                    children: IncidentSeverity.values
                        .map(
                          (v) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () => controller.severity.value = v,
                              child: Obx(
                                () {
                                  return Chip(
                                    label:
                                        Text(v.name.capitalizeFirst ?? v.name),
                                    backgroundColor: v.color.withOpacity(
                                      controller.severity.value == v ? 1 : 0.3,
                                    ),
                                    surfaceTintColor: v.color.withOpacity(0.6),
                                    side: BorderSide.none,
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                20.h,
                const FormLabel(label: 'Location'),
                Text(
                  'Whats the vehicle location?',
                  style: Get.textTheme.bodyMedium,
                ),
                5.0.h,
                GooglePlaceAutoCompleteTextField(
                  textEditingController: controller.locationCTRL,
                  googleAPIKey: Env.googleApiKey,
                  isLatLngRequired: true,
                  isCrossBtnShown: true,
                  showError: false,
                  itemClick: controller.onPrediction,
                  seperatedBuilder: Divider(color: Colors.grey[350]),
                  inputDecoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_rounded),
                  ),
                ),
                20.h,
                const FormLabel(label: 'Additional Notes (Optional)'),
                Text(
                  'Tell us more about the incident, e.g causes or current status.',
                  style: Get.textTheme.bodyMedium,
                ),
                5.0.h,
                TextFormField(
                  controller: controller.descriptionCTRL,
                  maxLength: 180,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Extra description or current status',
                  ),
                ),
                20.h,
                const FormLabel(label: 'Attach Media (Optional)'),
                Text(
                  'Provide media for even better understaing of the issue',
                  style: Get.textTheme.bodyMedium,
                ),
                5.0.h,
                SizedBox(
                  width: Get.width * 0.6,
                  child: Obx(
                    () {
                      return Visibility(
                        visible: controller.media.value == null,
                        replacement: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                    controller.media.value ?? File('')),
                              ),
                            ),
                            10.w,
                            GestureDetector(
                              onTap: () => controller.media.value = null,
                              child: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[400]!),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: GestureDetector(
                                onTap: () async => await controller.getImage(),
                                child: const Icon(
                                  Icons.add_photo_alternate_rounded,
                                  size: 45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.h,
                ElevatedButton(
                  onPressed: () async => await controller.reportIncident(),
                  style: Get.theme.elevatedButtonTheme.style?.copyWith(
                    minimumSize: WidgetStatePropertyAll(Size(Get.width, 45)),
                  ),
                  child: const Text(
                    'Report Incident',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                20.h,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
