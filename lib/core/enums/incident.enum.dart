import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum IncidentSeverity {
  low,
  medium,
  high,
}

extension IncidentSeverityExt on IncidentSeverity {
  Color get color {
    switch (this) {
      case IncidentSeverity.high:
        return const Color(0xffff3d00);
      case IncidentSeverity.medium:
        return const Color(0xffff9103);
      case IncidentSeverity.low:
        return const Color(0xffffc403);
    }
  }

  IconData get icon {
    switch (this) {
      case IncidentSeverity.high:
        return Icons.error_outline_rounded;
      case IncidentSeverity.medium:
        return Icons.warning_amber_rounded;
      case IncidentSeverity.low:
        return Icons.sync_problem_rounded;
    }
  }
}

enum IncidentStatus { pending, inProgess, resolved }

extension IncidentStatusExt on IncidentStatus {
  String get title {
    switch (this) {
      case IncidentStatus.inProgess:
        return 'progress';
      default:
        return name;
    }
  }

  Color get color {
    switch (this) {
      case IncidentStatus.pending:
        return const Color(0xffff3d00);
      case IncidentStatus.inProgess:
        return const Color(0xffff9103);
      case IncidentStatus.resolved:
        return Get.theme.primaryColor;
    }
  }

  bool get isDone => this == IncidentStatus.resolved;
}
