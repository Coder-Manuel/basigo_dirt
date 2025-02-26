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
  final remoteData = IncidentModel(
    title: 'Test Incident',
    severity: IncidentSeverity.medium,
    driver: UserModel(id: '1', name: 'driver', role: UserRole.driver),
    isSynced: true,
  );
  List<IncidentModel> localIncidents = List.generate(3, (_) => localData);
  List<IncidentModel> remoteIncidents = List.generate(8, (_) => remoteData);

  setUpAll(() {
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

    when(remoteDataSource.streamIncidents())
        .thenAnswer((_) => Stream.value(remoteIncidents));
    when(localDataSource.streamIncidents())
        .thenAnswer((_) => Stream.value(localIncidents));
  });

  tearDownAll(() {
    Get.deleteAll();
  });

  test(
    'should stream from the remote dataSource and return a stream',
    () async {
      connectivityCTRL.onConnectionUpdate(null, true);
      final response = getIncidentUseCase(null);
      verify(remoteDataSource.streamIncidents()).called(1);

      Stream<List<Incident>>? stream;

      response.fold(
        (ex) => fail('Expected SuccessResponse but got: ${ex.message}'),
        (data) => stream = data,
      );

      expectLater(stream, emitsInOrder([remoteIncidents]));

      verifyNoMoreInteractions(remoteDataSource);
    },
  );

  test(
    'should stream from the local dataSource and return a stream',
    () async {
      connectivityCTRL.onConnectionUpdate(null, false);
      final response = getIncidentUseCase(null);

      Stream<List<Incident>>? stream;

      response.fold(
        (ex) => fail('Expected SuccessResponse but got: ${ex.message}'),
        (data) => stream = data,
      );

      await expectLater(stream, emitsThrough(localIncidents));
      verify(localDataSource.streamIncidents()).called(greaterThan(0));
    },
  );

  test(
    'should change streams from remote to local auto when connection changes',
    () async {
      connectivityCTRL.onConnectionUpdate(null, true);
      final response = getIncidentUseCase(null);
      Stream<List<Incident>>? stream;
      response.fold(
        (ex) => fail('Expected SuccessResponse but got: ${ex.message}'),
        (data) => stream = data,
      );

      await expectLater(
        stream,
        emitsInOrder([remoteIncidents]),
      );
      verify(remoteDataSource.streamIncidents()).called(greaterThan(0));

      // SWitch to offline mode:
      connectivityCTRL.onConnectionUpdate(null, false);
      await expectLater(
        stream,
        emitsThrough(localIncidents),
      );
      verify(localDataSource.streamIncidents()).called(greaterThan(0));
    },
  );
}
