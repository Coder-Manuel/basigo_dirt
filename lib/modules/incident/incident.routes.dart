import 'package:basigo_dirt/core/middlewares/auth.middleware.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/create_incident.page.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/driver_incidents_page.dart';
import 'package:get/get.dart';

class IncidentRoutes {
  static List<GetPage> pages = <GetPage>[
    GetPage(
      name: DriverIncidentsPage.route,
      middlewares: [AuthGuardMiddleware()],
      page: () => const DriverIncidentsPage(),
    ),
    GetPage(
      name: CreateIncidentPage.route,
      middlewares: [AuthGuardMiddleware()],
      page: () => const CreateIncidentPage(),
    ),
  ];
}
