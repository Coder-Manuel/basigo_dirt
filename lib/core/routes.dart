import 'package:basigo_dirt/modules/auth/auth.routes.dart';
import 'package:basigo_dirt/modules/incident/incident.routes.dart';
import 'package:get/get.dart';

class NavRoutes {
  static List<GetPage> pages = [
    ...AuthRoutes.pages,
    ...IncidentRoutes.pages,
  ];
}
