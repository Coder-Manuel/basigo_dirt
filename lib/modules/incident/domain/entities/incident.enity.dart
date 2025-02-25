import 'package:basigo_dirt/core/enums/incident.enum.dart';

class Incident {
  final String id;
  final String title;
  final String? description;
  final IncidentStatus status;
  final IncidentSeverity severity;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isSynced;

  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.severity,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
}
