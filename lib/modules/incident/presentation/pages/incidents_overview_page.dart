import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:basigo_dirt/modules/auth/presentation/widgets/logout_button.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/incident_overview.controller.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/driver_incidents_page.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_analytics_card.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/latest_incidents_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentsOverviewPage extends GetView<IncidentOverviewController> {
  static String route = '/incidents_overview_page';
  const IncidentsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Incidents Overview'),
        actions: const [LogoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: IncidentAnalyticsCard(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Latest Incidents',
                  style: Get.textTheme.titleLarge,
                ),
              ),
            ),
            const LatestIncidentsView(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => Get.toNamed(DriverIncidentsPage.route),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View More',
                        style: Get.textTheme.titleMedium?.copyWith(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      5.w,
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Get.theme.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
