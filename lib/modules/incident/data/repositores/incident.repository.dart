import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.enity.dart';

abstract class IncidentRepository {
  Future<RepoReponse<Incident>> createIncident(Incident incident);
  Stream<List<Incident>> getIncidentsStream({bool loadMore});
}
