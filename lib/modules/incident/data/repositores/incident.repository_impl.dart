import 'dart:io';

import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/utils/error_util/error_wrapper.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/remote_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final String _library = 'Incident Repository';
  final LocalIncidentDataSource localDataSource;
  final RemoteIncidentDataSource remoteDataSource;

  IncidentRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  ConnectivityController get connectivityCTRL =>
      Get.find<ConnectivityController>();

  @override
  Future<RepoReponse<Incident>> createIncident(Incident incident) async {
    final response = await ErrorWrapper.wrap<RepoReponse<Incident>>(
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
          await remoteDataSource.saveIncident(model);

          return SuccessResponse(model);
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
  RepoReponse<Stream<List<Incident>>> getIncidentsStream({
    bool loadMore = false,
  }) {
    // TODO: implement getIncidentsStream
    throw UnimplementedError();
  }
}
