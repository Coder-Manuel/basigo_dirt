import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/core/widgets/loading_shimmer.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/driver_incidents.controller.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/create_incident.page.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_item_card.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/no_incidemts_plaholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverIncidentsPage extends GetView<DriverIncidentsController> {
  static String route = '/driver_incidents_page';
  const DriverIncidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            controller.userUseCase.user?.role.isDriver == false,
        title: const Text('Incidents'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
          future: controller.getIncidents(),
          builder: (_, __) {
            return controller.obx(
              (_) {
                return CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: controller.incidents.length,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: IncidentItemCard(
                            incident: controller.incidents[i],
                            canEdit:
                                controller.userUseCase.user?.role.isDriver ==
                                    false,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              onLoading: const LoadingShimmer(),
              onEmpty: const NoIncidentsPlaceholder(),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: controller.userUseCase.user?.role.isDriver == true,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(CreateIncidentPage.route),
          child: const Icon(
            Icons.add_rounded,
            size: 40,
          ),
        ),
      ),
    );
  }
}
