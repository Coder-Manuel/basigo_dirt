import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/location.entity.dart';
import 'package:get/get.dart';

final incident = IncidentModel(
  title: 'Battery Warning',
  severity: IncidentSeverity.high,
  location: Location(address: 'Imara Daima', lat: 0.0, long: 0.0),
);

class DriverIncidentsController extends GetxController with StateMixin<bool> {
  final incidents = <Incident>[
    incident,
    incident.copyWith(
      title: 'Brakes Failure',
      severity: IncidentSeverity.medium,
      status: IncidentStatus.inProgess,
      location: Location(address: 'Westlands', lat: 0, long: 0),
    ),
    incident.copyWith(
      title: 'Electronics Malfunction',
      severity: IncidentSeverity.high,
      status: IncidentStatus.pending,
    ),
    incident.copyWith(
      title: 'Warning Lights',
      severity: IncidentSeverity.low,
      status: IncidentStatus.resolved,
      location: Location(address: 'Ramco Court, Mombasa Road', lat: 0, long: 0),
    ),
  ];

  Future<void> getIncidents() async {
    change(false, status: RxStatus.loading());
    await Future.delayed(const Duration(seconds: 1));
    change(true, status: RxStatus.success());
  }
}
