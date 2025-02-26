import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/data/repositores/incident.repository_impl.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:basigo_dirt/modules/incident/domain/usecases/create_incident.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock.mocks.dart';

void main() {
  late MockLocalIncidentDataSource localDataSource;
  late MockRemoteIncidentDataSource remoteDataSource;
  late ConnectivityController connectivityCTRL;
  late CreateIncidentUseCase createIncidentUseCase;

  final incident = IncidentModel(
    title: 'Test Incident',
    severity: IncidentSeverity.medium,
    driver: UserModel(id: '1', name: 'driver', role: UserRole.driver),
  );
  final incidentMatcher = predicate<IncidentModel>((i) => i.id == incident.id);

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
    createIncidentUseCase = CreateIncidentUseCase();

    when(remoteDataSource.saveIncident(argThat(incidentMatcher)))
        .thenAnswer((_) async => incident);
    when(localDataSource.saveIncident(argThat(incidentMatcher)))
        .thenAnswer((_) async {});
  });

  test(
    'should createIncident on the local dataSource and return a success',
    () async {
      connectivityCTRL.onConnectionUpdate(null, false);

      final response = await createIncidentUseCase.call(incident);
      verify(localDataSource.saveIncident(argThat(incidentMatcher))).called(1);

      response.fold(
        (ex) => fail('Expected SuccessResponse but got: ${ex.message}'),
        (data) => expect(data.id, equals(incident.id)),
      );
    },
  );

  test(
    'should createIncident on the remote dataSource and return a success',
    () async {
      connectivityCTRL.onConnectionUpdate(null, true);
      final response = await createIncidentUseCase.call(incident);
      verify(remoteDataSource.saveIncident(argThat(incidentMatcher))).called(1);

      response.fold(
        (ex) => fail('Expected SuccessResponse but got: ${ex.message}'),
        (data) => expect(data.id, equals(incident.id)),
      );
    },
  );
}
