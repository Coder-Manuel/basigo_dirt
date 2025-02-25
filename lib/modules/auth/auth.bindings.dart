import 'package:basigo_dirt/modules/auth/data/repositores/auth.respository_impl.dart';
import 'package:basigo_dirt/modules/auth/data/sources/local_auth.dts.dart';
import 'package:basigo_dirt/modules/auth/data/sources/remote_auth_dts.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/login.controller.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/splash_page.controller.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SplashPageController(), fenix: true);

    await Get.putAsync<LocalAuthDataSource>(
      () async => await LocalAuthDTSImpl().init(),
      permanent: true,
    );

    Get.lazyPut<RemoteAuthDataSource>(
      () => RemoteAuthDTSImpl(),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteAuthDTS: Get.find<RemoteAuthDataSource>(),
        localAuthDTS: Get.find<LocalAuthDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
