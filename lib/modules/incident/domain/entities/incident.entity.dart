import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/location.entity.dart';

class Incident {
  final String id;
  final String title;
  final Location location;
  final String? description;
  final String? imageUrl;
  final String? dispatchComments;
  final IncidentStatus status;
  final IncidentSeverity severity;
  final User driver;
  final User? dispatch;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isSynced;

  Incident({
    required this.id,
    required this.title,
    required this.location,
    this.description,
    this.imageUrl,
    this.dispatchComments,
    required this.status,
    required this.severity,
    required this.driver,
    this.dispatch,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
}
