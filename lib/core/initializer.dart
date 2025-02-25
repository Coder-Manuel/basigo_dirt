import 'package:basigo_dirt/core/services/monitor_service/monitor.service.dart';
import 'package:basigo_dirt/core/utils/storage_util/storage.util.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/connectivity_controller.dart';
import 'package:basigo_dirt/firebase_options.dart';
import 'package:basigo_dirt/modules/auth/auth.bindings.dart';
import 'package:basigo_dirt/modules/incident/incident.bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Initializer {
  static Future<void> _injectServices() async {
    Get.put(ConnectivityController(), permanent: true);
    AuthBindings().dependencies();
    IncidentBindings().dependencies();
  }

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await MonitorService.init();
    await StorageUtil.init();

    await _injectServices();
  }
}
