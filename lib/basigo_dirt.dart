import 'package:basigo_dirt/config/theme.dart';
import 'package:basigo_dirt/core/routes.dart';
import 'package:basigo_dirt/core/widgets/offline_widget/offline_widget.dart';
import 'package:basigo_dirt/modules/auth/presentation/pages/splash.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BasigoDirt extends StatelessWidget {
  const BasigoDirt({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        return GetMaterialApp(
          title: 'BasiGo D.I.R.T',
          theme: Themes.normal,
          initialRoute: SplashPage.route,
          getPages: NavRoutes.pages,
          debugShowCheckedModeBanner: false,
          smartManagement: SmartManagement.keepFactory,
          builder: EasyLoading.init(
            builder: (context, child) => Stack(
              children: [
                child!,
                const OfflineWidget(),
              ],
            ),
          ),
          defaultTransition: Transition.rightToLeft,
        );
      },
    );
  }
}
