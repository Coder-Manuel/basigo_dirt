import 'dart:async';

import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:get/get.dart';

class LoginUseCase implements UseCase<User, ({String email, String password})> {
  final authRepository = Get.find<AuthRepository>();

  @override
  FutureOr<RepoReponse<User>> call(params) {
    return authRepository.login(email: params.email, password: params.password);
  }
}
