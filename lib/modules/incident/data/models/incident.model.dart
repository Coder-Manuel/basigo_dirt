import 'dart:convert';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/incident/data/models/location.model.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.entity.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/location.entity.dart';
import 'package:uuid/uuid.dart';

class IncidentModel extends Incident {
  IncidentModel({
    String? id,
    required super.title,
    super.description,
    super.imageUrl,
    super.dispatchComments,
    Location? location,
    IncidentStatus? status,
    required super.severity,
    required super.driver,
    super.dispatch,
    DateTime? createdAt,
    super.updatedAt,
    super.isSynced = false,
  }) : super(
          id: id ?? const Uuid().v4(),
          location: location ?? LocationModel.nan,
          status: status ?? IncidentStatus.pending,
          createdAt: createdAt ?? DateTime.now(),
        );

  factory IncidentModel.fromMap(Map<String, dynamic> map) => IncidentModel(
        id: map['id'] ?? '',
        title: map['title'] ?? 'NA',
        location: map['location'] != null
            ? LocationModel.fromMap(map['location'])
            : null,
        description: map['description'],
        imageUrl: map['imageUrl'],
        dispatchComments: map['dispatchComments'],
        status: map['status'] != null
            ? IncidentStatus.values.firstWhere(
                (v) => v.name == map['status'],
                orElse: () => IncidentStatus.inProgess,
              )
            : null,
        severity: IncidentSeverity.values.firstWhere(
          (v) => v.name == map['severity'],
          orElse: () => IncidentSeverity.low,
        ),
        driver: UserModel.fromMap(map['driver']),
        dispatch:
            map['dispatch'] != null ? UserModel.fromMap(map['dispatch']) : null,
        createdAt:
            map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
        updatedAt:
            map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
        isSynced: map['isSynced'] ?? false,
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'location': LocationModel.fromEntity(location).toMap,
        'description': description,
        'imageUrl': imageUrl,
        'dispatchComments': dispatchComments,
        'status': status.name,
        'severity': severity.name,
        'driver': UserModel.fromEntity(driver).toMap,
        'dispatch':
            dispatch == null ? null : UserModel.fromEntity(dispatch!).toMap,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'isSynced': isSynced,
      };

  factory IncidentModel.fromEntity(Incident entity) => IncidentModel(
        id: entity.id,
        title: entity.title,
        location: entity.location,
        description: entity.description,
        imageUrl: entity.imageUrl,
        dispatchComments: entity.dispatchComments,
        status: entity.status,
        severity: entity.severity,
        driver: entity.driver,
        dispatch: entity.dispatch,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        isSynced: entity.isSynced,
      );

  String get toJson => jsonEncode(toMap);

  factory IncidentModel.fromJson(String jsonString) => IncidentModel.fromMap(
        jsonDecode(jsonString),
      );

  IncidentModel copyWith({
    String? title,
    Location? location,
    String? description,
    String? imageUrl,
    String? dispatchComments,
    IncidentStatus? status,
    IncidentSeverity? severity,
    User? driver,
    User? dispatch,
    DateTime? updatedAt,
    bool? isSynced,
  }) =>
      IncidentModel(
        id: id,
        title: title ?? this.title,
        location: location ?? this.location,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        dispatchComments: dispatchComments ?? this.dispatchComments,
        status: status ?? this.status,
        severity: severity ?? this.severity,
        driver: driver ?? this.driver,
        dispatch: dispatch ?? this.dispatch,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isSynced: isSynced ?? this.isSynced,
      );
}
