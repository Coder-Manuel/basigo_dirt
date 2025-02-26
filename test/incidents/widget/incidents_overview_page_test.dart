import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/widgets/app_dropdown.dart';
import 'package:basigo_dirt/core/widgets/loading_shimmer.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:basigo_dirt/modules/auth/data/repositores/auth.respository_impl.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/splash_page.controller.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/data/repositores/incident.repository_impl.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/driver_incidents.controller.dart';
import 'package:basigo_dirt/modules/incident/presentation/controllers/incident_overview.controller.dart';
import 'package:basigo_dirt/modules/incident/presentation/pages/incidents_overview_page.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_action_sheet.dart';
import 'package:basigo_dirt/modules/incident/presentation/widgets/incident_analytics_card.dart';
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

  final user = UserModel(id: '1', name: 'dispatch', role: UserRole.dispatch);
  final model = IncidentModel(
    title: 'Test Incident',
    severity: IncidentSeverity.medium,
    driver: UserModel(id: '1', name: 'driver', role: UserRole.driver),
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
      final overviewCTRL = Get.put(IncidentOverviewController());
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents())
          .thenAnswer((_) => Stream.value([]));
      when(remoteIncidentDS.getIncidents(
        startDate: overviewCTRL.analysisFilter.value.startDate,
      )).thenAnswer((_) => Future.value([]));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: IncidentsOverviewPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));
      expect(find.byType(NoIncidentsPlaceholder), findsNothing);

      await tester.pumpAndSettle();
      expect(find.byType(NoIncidentsPlaceholder), findsOne);
      expect(find.byType(LoadingShimmer), findsNothing);
      expect(find.text('Latest Incidents'), findsOne);
    },
  );

  testWidgets(
    'should render atleast 2 items when incidents found',
    (tester) async {
      final overviewCTRL = Get.put(IncidentOverviewController());
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents())
          .thenAnswer((_) => Stream.value(remoteIncidents));
      when(remoteIncidentDS.getIncidents(
        startDate: overviewCTRL.analysisFilter.value.startDate,
      )).thenAnswer((_) => Future.value([]));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: IncidentsOverviewPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));

      await tester.pumpAndSettle();
      expect(find.byType(LoadingShimmer), findsNothing);
      expect(find.byType(NoIncidentsPlaceholder), findsNothing);
      expect(find.text('Latest Incidents'), findsOne);
      expect(find.byType(IncidentItemCard), findsAtLeast(2));
      expect(find.text('View More'), findsOne);
    },
  );

  testWidgets(
    'should render analysis overview card and its components correctly',
    (tester) async {
      final overviewCTRL = Get.put(IncidentOverviewController());
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents())
          .thenAnswer((_) => Stream.value(remoteIncidents));
      when(remoteIncidentDS.getIncidents(
        startDate: overviewCTRL.analysisFilter.value.startDate,
      )).thenAnswer((_) => Future.value(remoteIncidents));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: IncidentsOverviewPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));

      await tester.pumpAndSettle();
      expect(find.byType(LoadingShimmer), findsNothing);
      expect(find.byType(NoIncidentsPlaceholder), findsNothing);
      expect(find.byType(IncidentAnalyticsCard), findsOne);
      expect(find.text('Total Incidents'), findsOne);
      expect(find.text('${remoteIncidents.length}'), findsOne);
      expect(find.text('Severity'), findsOne);
      expect(find.text('Status'), findsOne);
      expect(find.byType(AppDropDownField<IncidentAnalysisFilter>), findsOne);
    },
  );

  testWidgets(
    'should render incident bottom sheet correctly',
    (tester) async {
      final overviewCTRL = Get.put(IncidentOverviewController());
      Get.put(DriverIncidentsController());
      when(remoteIncidentDS.streamIncidents())
          .thenAnswer((_) => Stream.value(remoteIncidents));
      when(remoteIncidentDS.getIncidents(
        startDate: overviewCTRL.analysisFilter.value.startDate,
      )).thenAnswer((_) => Future.value([]));

      // Now run the app
      await tester.pumpWidget(const Wrapper(child: IncidentsOverviewPage()));
      expect(find.byType(LoadingShimmer), findsAtLeast(1));

      await tester.pumpAndSettle();
      expect(find.byType(LoadingShimmer), findsNothing);
      expect(find.byType(NoIncidentsPlaceholder), findsNothing);
      expect(find.text('Latest Incidents'), findsOne);
      expect(find.byType(IncidentItemCard), findsAtLeast(2));
      expect(find.text('View More'), findsOne);

      await tester.tap(find.byType(IncidentItemCard).first);
      await tester.pumpAndSettle();
      expect(find.byType(IncidentActionSheet), findsOneWidget);
      expect(find.text('Update Incident'), findsOneWidget);

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(find.byType(IncidentActionSheet), findsNothing);
      expect(find.text('Update Incident'), findsNothing);
    },
  );
}
