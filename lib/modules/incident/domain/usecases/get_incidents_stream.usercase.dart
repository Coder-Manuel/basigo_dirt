import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class GetIncidentsStreamUseCase extends UseCase<Stream<List<Incident>>, User?> {
  final _incidentRepository = Get.find<IncidentRepository>();

  @override
  RepoReponse<Stream<List<Incident>>> call(User? params) {
    return _incidentRepository.getIncidentsStream(user: params);
  }

  void dispose() => _incidentRepository.disposeStream();
}
