import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/widgets/app_dropdown.dart';
import 'package:basigo_dirt/core/widgets/loading_shimmer.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/incident_overview.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentAnalyticsCard extends GetView<IncidentOverviewController> {
  const IncidentAnalyticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getIncidentAnalysis(),
      builder: (_, __) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Incidents",
                      style: Get.textTheme.titleMedium,
                    ),
                    SizedBox(
                      width: 150,
                      height: 35,
                      child: AppDropDownField<IncidentAnalysisFilter>(
                        value: controller.analysisFilter.value,
                        onChanged: (v) {
                          if (v != null) {
                            controller.analysisFilter.value = v;
                            controller.getIncidentAnalysis();
                          }
                        },
                        items: IncidentAnalysisFilter.values.map((v) {
                          return DropdownMenuItem(
                            value: v,
                            child: Text(v.title),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                controller.obx(
                  (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.analysis.value?.total ?? 0}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                        const Divider(),
                        Text(
                          "Severity",
                          style: Get.textTheme.titleMedium,
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 10,
                          children: (controller.analysis.value?.severity ?? {})
                              .entries
                              .map(
                                (e) => Chip(
                                  label: Text(
                                    "${e.key.name.capitalize}: ${e.value}",
                                  ),
                                  backgroundColor:
                                      Get.theme.primaryColor.withOpacity(0.2),
                                  side: BorderSide.none,
                                ),
                              )
                              .toList(),
                        ),
                        const Divider(),
                        Text(
                          "Status",
                          style: Get.textTheme.titleMedium,
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 10,
                          children: (controller.analysis.value?.statuses ?? {})
                              .entries
                              .map(
                                (e) => Chip(
                                  label: Text(
                                    "${e.key.title.capitalize}: ${e.value}",
                                  ),
                                  backgroundColor:
                                      Get.theme.primaryColor.withOpacity(0.2),
                                  side: BorderSide.none,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  },
                  onLoading: const LoadingShimmer(length: 1, width: 80),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
