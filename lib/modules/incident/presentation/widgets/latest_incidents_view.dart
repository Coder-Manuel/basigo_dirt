import 'package:basigo_dirt/core/widgets/loading_shimmer.dart';
import 'package:basigo_dirt/core/widgets/retry_widget.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/driver_incidents.controller.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_item_card.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/no_incidemts_plaholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestIncidentsView extends GetView<DriverIncidentsController> {
  const LatestIncidentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getIncidents(),
      builder: (_, __) {
        final list = controller.incidents.take(2).toList();
        return controller.obx(
          (_) {
            return SliverList.builder(
              itemCount: list.length,
              itemBuilder: (_, i) {
                return IncidentItemCard(incident: list[i]);
              },
            );
          },
          onLoading: const SliverToBoxAdapter(child: LoadingShimmer(length: 1)),
          onEmpty: const SliverToBoxAdapter(
            child: NoIncidentsPlaceholder(topMargin: 20),
          ),
          onError: (e) => SliverToBoxAdapter(
            child: RetryWidget(
              onRetry: () => controller.getIncidents(reload: true),
            ),
          ),
        );
      },
    );
  }
}
