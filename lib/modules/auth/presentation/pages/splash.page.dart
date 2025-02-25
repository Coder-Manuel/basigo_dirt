import 'package:basigo_dirt/config/assets/app.images.dart';
import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/splash_page.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashPageController> {
  static String route = '/splash_page';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.goToHome(),
        builder: (_, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.textLogo, height: 100),
                30.0.h,
                Text(
                  'Dispatch & Incident Report Tool (D.I.R.T)',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
