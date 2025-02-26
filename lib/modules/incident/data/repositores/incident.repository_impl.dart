import 'dart:async';
import 'dart:io';

import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/utils/error_util/error_wrapper.dart';
import 'package:basigo_dirt/core/utils/logger.util.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/remote_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident_analysis.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final String _library = 'Incident Repository';
  final LocalIncidentDataSource localDataSource;
  final RemoteIncidentDataSource remoteDataSource;

  IncidentRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  }) {
    setupConnectivityStream();
  }

  ConnectivityController get connectivityCTRL =>
      Get.find<ConnectivityController>();

  StreamController<List<Incident>> _incidentStreamController =
      StreamController.broadcast();
  StreamSubscription<List<Incident>>? _remoteSubscription;
  StreamSubscription<List<Incident>>? _localSubscription;

  void setupConnectivityStream() {
    connectivityCTRL.onConnectivityChanged.listen((isConnected) {
      getIncidentsStream();
      if (isConnected) _syncOfflineData();
    });
  }

  @override
  Future<RepoReponse<Incident>> createIncident(Incident incident) async {
    final response = await ErrorWrapper.async<RepoReponse<Incident>>(
      () async {
        if (connectivityCTRL.isConnected) {
          String? imageUrl = incident.imageUrl;
          if (incident.imageUrl?.isNotEmpty == true) {
            imageUrl = await remoteDataSource.uploadImage(
              File(incident.imageUrl!),
            );
          }
          final model = IncidentModel.fromEntity(incident).copyWith(
            imageUrl: imageUrl,
            isSynced: true,
          );
          final savedModel = await remoteDataSource.saveIncident(model);
          if (savedModel == null) {
            return FailureResponse('Unable to create incident, Kindly Retry');
          }

          return SuccessResponse(savedModel);
        } else {
          final model = IncidentModel.fromEntity(incident);
          await localDataSource.saveIncident(model);

          return SuccessResponse(model);
        }
      },
      onError: (e) => FailureResponse('An error occured, Kindly Retry'),
      library: _library,
      description: 'while reporting an incident',
    );

    return response!;
  }

  @override
  Future<RepoReponse<Incident>> updateIncident(Incident incident) async {
    final response = await ErrorWrapper.async<RepoReponse<Incident>>(
      () async {
        if (!connectivityCTRL.isConnected) {
          return FailureResponse(
            'Youre offline, Check your internet and retry',
          );
        }
        final model = IncidentModel.fromEntity(incident);
        await remoteDataSource.saveIncident(model);

        return SuccessResponse(model);
      },
      onError: (e) => FailureResponse('An error occured, Kindly Retry'),
      library: _library,
      description: 'while updating an incident',
    );

    return response!;
  }

  @override
  RepoReponse<Stream<List<Incident>>> getIncidentsStream({User? user}) {
    final response = ErrorWrapper.sync<RepoReponse<Stream<List<Incident>>>>(
      () {
        _remoteSubscription?.cancel();
        _localSubscription?.cancel();
        String? userId;
        if (user?.role == UserRole.driver) {
          userId = user?.id;
        }

        if (_incidentStreamController.isClosed) {
          _incidentStreamController =
              StreamController<List<Incident>>.broadcast();
        }

        if (connectivityCTRL.isConnected) {
          _remoteSubscription =
              remoteDataSource.streamIncidents(userId: userId).listen(
                    (data) => _incidentStreamController.add(data),
                    onError: (e) => _incidentStreamController.addError(e),
                  );
        } else {
          _localSubscription = localDataSource.streamIncidents().listen(
                (data) => _incidentStreamController.add(data),
                onError: (e) => _incidentStreamController.addError(e),
              );
        }

        return SuccessResponse(_incidentStreamController.stream);
      },
      onError: (e) {
        if (_incidentStreamController.isClosed) {
          return FailureResponse('An error occurred, Kindly Retry');
        } else {
          _incidentStreamController.addError(e);
          return SuccessResponse(_incidentStreamController.stream);
        }
      },
      library: _library,
      description: 'while getting incident streams',
    );

    return response!;
  }

  @override
  Future<RepoReponse<IncidentAnalysis>> getIncidentAnalysis(
    IncidentAnalysisFilter filter,
  ) async {
    final response = await ErrorWrapper.async<RepoReponse<IncidentAnalysis>>(
      () async {
        if (!connectivityCTRL.isConnected) {
          return FailureResponse(
            'Youre offline, Check your internet and retry',
          );
        }

        final incidents = await remoteDataSource.getIncidents(
          startDate: filter.startDate,
        );
        Map<IncidentSeverity, int> severity = {};
        Map<IncidentStatus, int> status = {};

        for (final inc in incidents) {
          final severityKey = inc.severity;
          severity[severityKey] = (severity[severityKey] ?? 0) + 1;

          // Count statuses
          final statusKey = inc.status;
          status[statusKey] = (status[statusKey] ?? 0) + 1;
        }

        return SuccessResponse(
          IncidentAnalysis(
            total: incidents.length,
            statuses: status,
            severity: severity,
          ),
        );
      },
      onError: (e) => FailureResponse('An error occured, Kindly Retry'),
      library: _library,
      description: 'while fetching incident analysis',
    );

    return response!;
  }

  @override
  void disposeStream() {
    _remoteSubscription?.cancel();
    _localSubscription?.cancel();
    _incidentStreamController.close();
    localDataSource.disposeStream();
  }

  Future<void> _syncOfflineData() async {
    await ErrorWrapper.async(
      () async {
        final cache = localDataSource.getIncidents(offlineOnly: true);
        if (connectivityCTRL.isConnected) {
          Logger.log('=== SYNCING OFFLINE DATA ====');
          for (final data in cache) {
            String? imageUrl = data.imageUrl;
            if (data.imageUrl?.isNotEmpty == true) {
              imageUrl = await remoteDataSource.uploadImage(
                File(data.imageUrl!),
              );
            }
            final model = IncidentModel.fromEntity(data).copyWith(
              imageUrl: imageUrl,
              isSynced: true,
            );
            await remoteDataSource.saveIncident(model);
            localDataSource.saveIncident(model);
          }
        }
      },
      library: _library,
      description: 'while syncing offline data',
    );
  }
}
