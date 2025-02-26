import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/remote_incident.dts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

@GenerateNiceMocks([
  MockSpec<RemoteIncidentDataSource>(),
  MockSpec<LocalIncidentDataSource>(),
])
class MockConnectivityController extends GetxController
    with Mock
    implements ConnectivityController {}

void main() {}
