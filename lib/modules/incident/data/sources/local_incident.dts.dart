import 'dart:async';

import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:hive/hive.dart';

abstract class LocalIncidentDataSource {
  Future<void> saveIncident(IncidentModel incident);
  Future<void> cacheIncidents(List<IncidentModel> incidents);
  List<IncidentModel> getIncidents({int limit = 10, bool offlineOnly = false});
  Stream<List<IncidentModel>> streamIncidents({int limit = 10});
  void disposeStream();
}

class LocalIncidentDTSImpl implements LocalIncidentDataSource {
  late Box<String> incidentBox;

  LocalIncidentDTSImpl();

  Future<LocalIncidentDTSImpl> init() async {
    incidentBox = await Hive.openBox('incidents');
    return this;
  }

  StreamController<List<IncidentModel>> controller =
      StreamController<List<IncidentModel>>();

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
  List<IncidentModel> getIncidents({
    int start = 0,
    int limit = 10,
    bool offlineOnly = false,
  }) {
    final incidents =
        incidentBox.values.map((v) => IncidentModel.fromJson(v)).toList();

    incidents.sort((a, b) => b.createdAt.compareTo(b.createdAt));

    if (offlineOnly) {
      return incidents.where((v) => !v.isSynced).toList();
    }

    return incidents.sublist(start).take(limit).toList();
  }

  @override
  Stream<List<IncidentModel>> streamIncidents({int limit = 10}) {
    if (controller.isClosed) {
      controller = StreamController<List<IncidentModel>>();
    }
    controller.add(getIncidents(limit: limit));

    final subscription = incidentBox.watch().listen((_) {
      controller.add(getIncidents());
    });

    controller.onCancel = () {
      subscription.cancel();
    };

    return controller.stream;
  }

  @override
  void disposeStream() {
    controller.close();
  }
}
