import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class CreateIncidentUseCase implements UseCase<Incident, Incident> {
  final _incidentRepository = Get.find<IncidentRepository>();

  @override
  Future<RepoReponse<Incident>> call(Incident incident) {
    return _incidentRepository.createIncident(incident);
  }
}
