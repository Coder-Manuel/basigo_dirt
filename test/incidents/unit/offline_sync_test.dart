import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/data/repositores/incident.repository_impl.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:basigo_dirt/modules/incident/domain/usecases/get_incidents_stream.usercase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock.mocks.dart';

void main() {
  late MockLocalIncidentDataSource localDataSource;
  late MockRemoteIncidentDataSource remoteDataSource;
  late ConnectivityController connectivityCTRL;
  late GetIncidentsStreamUseCase getIncidentUseCase;

  final localData = IncidentModel(
    title: 'Test Incident',
    severity: IncidentSeverity.medium,
    driver: UserModel(id: '1', name: 'driver', role: UserRole.driver),
  );
  List<IncidentModel> localIncidents = List.generate(3, (_) => localData);
  List<IncidentModel> cacheIncidents =
      List.generate(3, (_) => localData.copyWith());

  setUp(() {
    Get.testMode = true;
    localDataSource = MockLocalIncidentDataSource();
    remoteDataSource = MockRemoteIncidentDataSource();
    connectivityCTRL = Get.put(ConnectivityController());
    Get.put<IncidentRepository>(
      IncidentRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
      ),
    );
    getIncidentUseCase = GetIncidentsStreamUseCase();
  });

  tearDownAll(() {
    Get.deleteAll();
  });

  test(
    'should sync offline data to remote server on online connectivity',
    () async {
      when(localDataSource.streamIncidents())
          .thenAnswer((_) => Stream.value(localIncidents));
      connectivityCTRL.onConnectionUpdate(null, false);
      final response = getIncidentUseCase(null);

      Stream<List<Incident>>? stream;
      response.fold(
        (ex) => fail('Expected SuccessResponse but got: ${ex.message}'),
        (data) => stream = data,
      );
      await expectLater(
        stream,
        emitsThrough(localIncidents),
      );
      verify(localDataSource.streamIncidents()).called(greaterThan(0));
      verifyNever(localDataSource.getIncidents(offlineOnly: true));

      when(localDataSource.getIncidents(offlineOnly: true))
          .thenAnswer((_) => cacheIncidents);
      final matcher = predicate<IncidentModel>((i) => i.id == localData.id);
      when(remoteDataSource.saveIncident(argThat(matcher)))
          .thenAnswer((_) async => localData);

      connectivityCTRL.onConnectionUpdate(null, true);
      await Future.delayed(const Duration(seconds: 1));
      verify(localDataSource.getIncidents(offlineOnly: true)).called(1);
      verify(remoteDataSource.saveIncident(argThat(matcher)))
          .called(cacheIncidents.length);
    },
  );
}
