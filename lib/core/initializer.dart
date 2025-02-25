import 'package:basigo_dirt/core/services/monitor_service/monitor.service.dart';
import 'package:basigo_dirt/core/utils/storage_util/storage.util.dart';
import 'package:basigo_dirt/modules/auth/auth.bindings.dart';
import 'package:basigo_dirt/modules/incident/incident.bindings.dart';
import 'package:flutter/material.dart';

class Initializer {
  static Future<void> _injectServices() async {
    AuthBindings().dependencies();
    IncidentBindings().dependencies();
  }

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await MonitorService.init();
    await StorageUtil.init();

    await _injectServices();
  }
}
