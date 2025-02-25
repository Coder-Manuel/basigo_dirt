import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:hive/hive.dart';

abstract class LocalIncidentDataSource {
  Future<void> saveIncident(IncidentModel incident);
  Future<void> cacheIncidents(List<IncidentModel> incidents);
  List<IncidentModel> getIncidents({int limit = 10});
}

class LocalIncidentDTSImpl implements LocalIncidentDataSource {
  late Box<String> incidentBox;

  LocalIncidentDTSImpl();

  Future<LocalIncidentDTSImpl> init() async {
    incidentBox = await Hive.openBox('incidents');
    return this;
  }

  @override
  Future<void> saveIncident(IncidentModel incident) async {
    await incidentBox.put(incident.id, incident.toJson);
  }

  @override
  Future<void> cacheIncidents(List<IncidentModel> incidents) async {
    final Map<String, String> incidentMap = {
      for (var inc in incidents) inc.id: inc.toJson
    };
    await incidentBox.putAll(incidentMap);
  }

  @override
  List<IncidentModel> getIncidents({int start = 0, int limit = 10}) {
    final incidents =
        incidentBox.values.map((v) => IncidentModel.fromJson(v)).toList();

    incidents.sort((a, b) => b.createdAt.compareTo(b.createdAt));

    return incidents.sublist(start).take(limit).toList();
  }
}
