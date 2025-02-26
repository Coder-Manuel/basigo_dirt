import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/widgets/loading_shimmer.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/core/widgets/retry_widget.dart';
import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:basigo_dirt/modules/auth/data/repositores/auth.respository_impl.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/splash_page.controller.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/data/repositores/incident.repository_impl.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/driver_incidents.controller.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/driver_incidents_page.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_item_card.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/no_incidemts_plaholder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock.mocks.dart';
import '../../utils/wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRemoteIncidentDataSource remoteIncidentDS;
  late MockLocalIncidentDataSource locaIncidentDS;
  late MockLocalAuthDataSource localAuthDS;
  late MockRemoteAuthDataSource remoteAuthDS;

  final user = UserModel(id: '1', name: 'driver', role: UserRole.driver);
  final model = IncidentModel(
    title: 'Test Incident',
    severity: IncidentSeverity.medium,
    driver: user,
    isSynced: true,
  );
  List<IncidentModel> remoteIncidents = List.generate(8, (_) => model);

  setUp(() {
    Get.testMode = true;
    remoteIncidentDS = MockRemoteIncidentDataSource();
    locaIncidentDS = MockLocalIncidentDataSource();
    remoteAuthDS = MockRemoteAuthDataSource();
    localAuthDS = MockLocalAuthDataSource();
    Get.put(ConnectivityController());
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        localAuthDTS: localAuthDS,
        remoteAuthDTS: remoteAuthDS,
      ),
    );
    Get.put<IncidentRepository>(
      IncidentRepositoryImpl(
        localDataSource: locaIncidentDS,
        remoteDataSource: remoteIncidentDS,
      ),
    );
    Get.put(SplashPageController());
    when(remoteAuthDS.currentUser).thenAnswer((_) => user);
    when(localAuthDS.currentUser).thenAnswer((_) => user);
  });

  tearDown(() => Get.reset());

  testWidgets(
    'should render empty placeholder when no incidents found',
    (tester) async {
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents(userId: user.id))
          .thenAnswer((_) => Stream.value([]));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: DriverIncidentsPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));
      expect(find.byType(NoIncidentsPlaceholder), findsNothing);

      await tester.pumpAndSettle();
      expect(find.byType(NoIncidentsPlaceholder), findsAtLeast(1));
      expect(find.byType(LoadingShimmer), findsNothing);
    },
  );

  testWidgets(
    'should render error placeholder when error occurs',
    (tester) async {
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents(userId: user.id))
          .thenAnswer((_) => Stream.error(Exception('Stream Broken')));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: DriverIncidentsPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));
      expect(find.byType(RetryWidget), findsNothing);

      await tester.pumpAndSettle();
      expect(find.byType(RetryWidget), findsAtLeast(1));
      expect(find.byType(LoadingShimmer), findsNothing);
    },
  );

  testWidgets(
    'should retry getting stream and return render success',
    (tester) async {
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents(userId: user.id))
          .thenAnswer((_) => Stream.error(Exception('Stream Broken')));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: DriverIncidentsPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));
      expect(find.byType(RetryWidget), findsNothing);

      await tester.pumpAndSettle();
      expect(find.byType(RetryWidget), findsAtLeast(1));
      expect(find.byType(LoadingShimmer), findsNothing);

      expect(find.text('Retry'), findsAtLeast(1));
      when(remoteIncidentDS.streamIncidents(userId: user.id))
          .thenAnswer((_) => Stream.value(remoteIncidents));
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(find.byType(LoadingShimmer), findsNothing);
      expect(find.byType(RetryWidget), findsNothing);
      expect(find.byType(IncidentItemCard), findsAtLeast(3));
    },
  );
}
