import 'dart:io';

import 'package:basigo_dirt/modules/incident/data/models/incident.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteIncidentDataSource {
  Future<void> saveIncident(IncidentModel incident);
  Future<String?> uploadImage(File image);
  Future<List<IncidentModel>> getIncidents({DateTime? startDate});
  Stream<List<IncidentModel>> streamIncidents({String? userId});
}

class RemoteIncidentDTSImpl extends RemoteIncidentDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveIncident(IncidentModel incident) async {
    await firestore
        .collection('incidents')
        .doc(incident.id)
        .set(incident.toMap, SetOptions(merge: true));
  }

  @override
  Future<String?> uploadImage(File image) {
    return Future.value(
      'https://placehold.co/400x400/orange/white?text=Image',
    );
  }

  @override
  Future<List<IncidentModel>> getIncidents({
    DateTime? startDate,
  }) async {
    Query<IncidentModel> query = firestore
        .collection('incidents')
        .orderBy('createdAt', descending: true)
        .withConverter(
          fromFirestore: (snap, _) => IncidentModel.fromMap(snap.data() ?? {}),
          toFirestore: (data, _) => data.toMap,
        );

    if (startDate != null) {
      query = query.where(
        'createdAt',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }

    final incendents = await query.get();

    return incendents.docs.map((doc) => doc.data()).toList();
  }

  @override
  Stream<List<IncidentModel>> streamIncidents({String? userId}) {
    Query<IncidentModel> query = firestore
        .collection('incidents')
        .orderBy('createdAt', descending: true)
        .withConverter(
          fromFirestore: (snap, _) => IncidentModel.fromMap(snap.data() ?? {}),
          toFirestore: (data, _) => data.toMap,
        );

    if (userId?.isNotEmpty == true) {
      query = query.where('driver.id', isEqualTo: userId);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
