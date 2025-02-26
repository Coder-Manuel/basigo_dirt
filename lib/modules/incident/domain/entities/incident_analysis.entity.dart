import 'package:basigo_dirt/core/enums/incident.enum.dart';

class IncidentAnalysis {
  final int total;
  final Map<IncidentStatus, int> statuses;
  final Map<IncidentSeverity, int> severity;

  IncidentAnalysis({
    required this.total,
    required this.statuses,
    required this.severity,
  });
}
