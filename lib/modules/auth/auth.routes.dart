import 'package:basigo_dirt/modules/auth/presentation/pages/splash_page.dart';
import 'package:get/get.dart';

class AuthRoutes {
  static List<GetPage> pages = <GetPage>[
    GetPage(
      name: SplashPage.route,
      page: () => const SplashPage(),
    ),
  ];
}
