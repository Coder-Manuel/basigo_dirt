import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class GetIncidentsStreamUseCase extends UseCase<Stream<List<Incident>>, bool> {
  final _incidentRepository = Get.find<IncidentRepository>();

  @override
  RepoReponse<Stream<List<Incident>>> call(bool params) {
    return _incidentRepository.getIncidentsStream(loadMore: params);
  }

  void dispose() => _incidentRepository.disposeStream();
}
