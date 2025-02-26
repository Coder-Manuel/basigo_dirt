import 'dart:async';

import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident_analysis.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/repository/incident.repository.dart';
import 'package:get/get.dart';

class GetIncidentAnalysisUseCase
    extends UseCase<IncidentAnalysis, IncidentAnalysisFilter> {
  final _incidentRepository = Get.find<IncidentRepository>();

  @override
  FutureOr<RepoReponse<IncidentAnalysis>> call(IncidentAnalysisFilter params) {
    return _incidentRepository.getIncidentAnalysis(params);
  }
}
