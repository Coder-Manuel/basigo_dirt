import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:get/get.dart';

class IncidentBindings extends Bindings {
  @override
  void dependencies() async {
    await Get.putAsync<LocalIncidentDataSource>(
      () async => await LocalIncidentDTSImpl().init(),
    );
  }
}
