import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident_analysis.entity.dart';

abstract class IncidentRepository {
  Future<RepoReponse<Incident>> createIncident(Incident incident);
  Future<RepoReponse<Incident>> updateIncident(Incident incident);
  Future<RepoReponse<IncidentAnalysis>> getIncidentAnalysis(
    IncidentAnalysisFilter filter,
  );
  RepoReponse<Stream<List<Incident>>> getIncidentsStream({bool loadMore});
  void disposeStream();
}
