import 'dart:async';

import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:get/get.dart';

class LogoutUseCase implements UseCase<void, Type?> {
  final authRepository = Get.find<AuthRepository>();

  @override
  FutureOr<RepoReponse<void>> call(_) {
    return authRepository.logout();
  }
}
