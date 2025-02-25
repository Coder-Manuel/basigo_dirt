import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.enity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';

class GetIncidentsStreamUseCase extends UseCase<Stream<List<Incident>>, bool> {
  final IncidentRepository incidentRepository;

  GetIncidentsStreamUseCase(this.incidentRepository);

  @override
  RepoReponse<Stream<List<Incident>>> call(bool params) {
    return incidentRepository.getIncidentsStream(loadMore: params);
  }
}
