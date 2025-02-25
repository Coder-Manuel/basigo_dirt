import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormLabel extends StatelessWidget {
  final String label;

  const FormLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Get.textTheme.titleLarge?.copyWith(fontSize: 19),
    );
  }
}
