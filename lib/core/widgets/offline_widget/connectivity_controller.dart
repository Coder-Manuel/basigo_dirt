import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  Rx<bool> isInitialAppOpen = true.obs;
  Rx<bool> showConnectedIndicator = false.obs;
  Rx<ConnectivityStatus> connectivity = ConnectivityStatus.pending.obs;

  final _connectivityStreamController = StreamController<bool>.broadcast();
  Stream<bool> get onConnectivityChanged =>
      _connectivityStreamController.stream;

  bool get isConnected {
    return connectivity.value != ConnectivityStatus.disconnected;
  }

  void onConnectionUpdate(BuildContext? _, bool status) {
    if (status) {
      connectivity.value = ConnectivityStatus.connected;
    } else {
      connectivity.value = ConnectivityStatus.disconnected;
    }
    update();

    _connectivityStreamController.add(status);

    if (!isInitialAppOpen.value && status) {
      showConnectedIndicator.value = true;
      Future.delayed(const Duration(seconds: 3), () {
        showConnectedIndicator.value = false;
      });
    }

    isInitialAppOpen.value = false;
  }

  @override
  void onClose() {
    _connectivityStreamController.close();
    super.onClose();
  }
}

enum ConnectivityStatus {
  pending,
  connected,
  disconnected,
}
