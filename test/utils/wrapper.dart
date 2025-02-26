import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends StatelessWidget {
  final Widget? child;

  const Wrapper({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      home: Material(
        child: child,
      ),
    );
  }
}
