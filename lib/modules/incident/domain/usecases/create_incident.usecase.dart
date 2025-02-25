import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.enity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';

class CreateIncidentUseCase implements UseCase<Incident, Incident> {
  final IncidentRepository incidentRepository;

  CreateIncidentUseCase(this.incidentRepository);

  @override
  Future<RepoReponse<Incident>> call(Incident incident) {
    return incidentRepository.createIncident(incident);
  }
}
