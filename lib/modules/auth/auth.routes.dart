import 'package:basigo_dirt/modules/auth/presentation/pages/login.page.dart';
import 'package:basigo_dirt/modules/auth/presentation/pages/splash.page.dart';
import 'package:get/get.dart';

class AuthRoutes {
  static List<GetPage> pages = <GetPage>[
    GetPage(
      name: SplashPage.route,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: LoginPage.route,
      page: () => const LoginPage(),
    ),
  ];
}
