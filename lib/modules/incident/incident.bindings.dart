import 'package:basigo_dirt/modules/incident/data/repositores/incident.repository_impl.dart';
import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/remote_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class IncidentBindings extends Bindings {
  @override
  void dependencies() async {
    await Get.putAsync<LocalIncidentDataSource>(
      () async => await LocalIncidentDTSImpl().init(),
    );
    Get.lazyPut<RemoteIncidentDataSource>(() => RemoteIncidentDTSImpl());
    Get.lazyPut<IncidentRepository>(
      () => IncidentRepositoryImpl(
        localDataSource: Get.find<LocalIncidentDataSource>(),
        remoteDataSource: Get.find<RemoteIncidentDataSource>(),
      ),
    );
  }
}
