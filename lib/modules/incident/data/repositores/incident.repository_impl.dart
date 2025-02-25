import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/modules/incident/data/sources/local_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/data/sources/remote_incident.dts.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.enity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final LocalIncidentDataSource localDataSource;
  final RemoteIncidentDataSource remoteDataSource;

  IncidentRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<RepoReponse<Incident>> createIncident(Incident incident) {
    // TODO: implement createIncident
    throw UnimplementedError();
  }

  @override
  RepoReponse<Stream<List<Incident>>> getIncidentsStream({
    bool loadMore = false,
  }) {
    // TODO: implement getIncidentsStream
    throw UnimplementedError();
  }
}
