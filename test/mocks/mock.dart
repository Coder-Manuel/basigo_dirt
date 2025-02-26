import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/auth/data/sources/local_auth.dts.dart';
import 'package:basigo_dirt/modules/auth/data/sources/remote_auth_dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/remote_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/driver_incidents.controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

@GenerateNiceMocks([
  MockSpec<RemoteIncidentDataSource>(),
  MockSpec<LocalIncidentDataSource>(),
  MockSpec<RemoteAuthDataSource>(),
  MockSpec<LocalAuthDataSource>(),
])
class MockConnectivityController extends GetxController
    with Mock
    implements ConnectivityController {}

class MockDriverIncidentsController extends GetxController
    with Mock
    implements DriverIncidentsController {}

void main() {}
