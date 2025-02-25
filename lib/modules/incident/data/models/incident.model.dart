import 'dart:convert';
import 'package:basigo_dirt/core/enums/incident.enum.dart';
import 'package:basigo_dirt/modules/incident/domain/entities/incident.enity.dart';
import 'package:uuid/uuid.dart';

class IncidentModel extends Incident {
  IncidentModel({
    String? id,
    required super.title,
    super.description,
    IncidentStatus? status,
    required super.severity,
    DateTime? createdAt,
    super.updatedAt,
    super.isSynced = false,
  }) : super(
          id: id ?? const Uuid().v4(),
          status: status ?? IncidentStatus.inProgess,
          createdAt: createdAt ?? DateTime.now(),
        );

  factory IncidentModel.fromMap(Map<String, dynamic> map) => IncidentModel(
        id: map['id'] ?? '',
        title: map['title'] ?? 'NA',
        description: map['description'],
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
        createdAt:
            map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
        updatedAt:
            map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
        isSynced: map['isSynced'] ?? false,
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'description': description,
        'status': status.name,
        'severity': severity.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'isSynced': isSynced,
      };

  String get toJson => jsonEncode(toMap);

  factory IncidentModel.fromJson(String jsonString) => IncidentModel.fromMap(
        jsonDecode(jsonString),
      );

  IncidentModel copyWith({
    String? titleCpy,
    String? descriptionCpy,
    IncidentStatus? statusCpy,
    IncidentSeverity? severityCpy,
    DateTime? updatedAtCpy,
    bool? isSyncedCpy,
  }) =>
      IncidentModel(
        id: id,
        title: titleCpy ?? title,
        description: descriptionCpy ?? description,
        status: statusCpy ?? status,
        severity: severityCpy ?? severity,
        createdAt: createdAt,
        updatedAt: updatedAtCpy ?? updatedAt,
        isSynced: isSyncedCpy ?? isSynced,
      );
}
