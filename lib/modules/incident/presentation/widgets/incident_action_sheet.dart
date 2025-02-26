import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:basigo_dirt/core/widgets/app_dropdown.dart';
import 'package:basigo_dirt/core/widgets/form_label.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/incident_overview.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart';

class IncidentActionSheet extends GetView<IncidentOverviewController> {
  const IncidentActionSheet({
    super.key,
    required this.incident,
  });

  final Incident incident;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.updateDisplayItems(incident),
      builder: (_, __) {
        return Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          decoration: BoxDecoration(
            color: incident.severity.color.withOpacity(0.03),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                incident.title,
                style: Get.textTheme.headlineMedium,
              ),
              15.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        incident.severity.icon,
                        color: incident.status.isDone
                            ? Colors.grey
                            : incident.severity.color,
                      ),
                      10.w,
                      Chip(
                        label: Text(incident.severity.name.capitalizeFirst!),
                        backgroundColor: incident.status.isDone
                            ? Colors.grey
                            : incident.severity.color.withOpacity(0.8),
                        surfaceTintColor: incident.severity.color.withOpacity(
                          0.6,
                        ),
                        side: BorderSide.none,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: incident.status.isDone
                            ? Colors.grey
                            : Get.theme.primaryColor,
                      ),
                      5.w,
                      Text(incident.location.address),
                    ],
                  ),
                ],
              ),
              10.h,
              const FormLabel(label: 'Driver Notes:'),
              5.h,
              Text(
                incident.description ?? 'NA',
                style: Get.textTheme.headlineSmall?.copyWith(
                  fontSize: 18,
                ),
              ),
              5.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 15,
                    color: incident.status.isDone
                        ? Colors.grey
                        : Get.theme.primaryColor,
                  ),
                  2.0.w,
                  Text(
                    format(incident.updatedAt ?? incident.createdAt)
                        .replaceAll('minute', 'min'),
                    style: Get.textTheme.bodySmall?.copyWith(
                      color: incident.status.isDone
                          ? Colors.grey
                          : Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              FormLabel(
                label:
                    'Comments/Instructions ${incident.status.isDone ? '' : '(Optional)'} ',
              ),
              Text(
                'Add info to the incident.',
                style: Get.textTheme.bodyMedium,
              ),
              5.0.h,
              TextFormField(
                controller: controller.commentCTRL,
                maxLength: 100,
                minLines: 1,
                maxLines: 4,
                enabled: !incident.status.isDone,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: 'Instruction/Comment',
                ),
              ),
              10.h,
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: Get.textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  10.w,
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: AppDropDownField<IncidentStatus>(
                      enabled: !incident.status.isDone,
                      value: controller.incidentStatus.value,
                      onChanged: (v) => controller.incidentStatus.value = v,
                      items: IncidentStatus.values.map((v) {
                        return DropdownMenuItem(
                          value: v,
                          child: Text(v.name.capitalizeFirst!),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              25.h,
              Visibility(
                visible: !incident.status.isDone,
                child: ElevatedButton(
                  onPressed: () async => await controller.updateIncident(
                    incident,
                  ),
                  style: Get.theme.elevatedButtonTheme.style?.copyWith(
                    minimumSize: WidgetStatePropertyAll(Size(Get.width, 45)),
                  ),
                  child: const Text(
                    'Update Incident',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              20.h,
            ],
          ),
        );
      },
    );
  }
}
