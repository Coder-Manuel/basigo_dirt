import 'dart:async';

import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/usecase/usecase.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:get/get.dart';

class FetchUserUseCase implements UseCase<User?, String> {
  final authRepository = Get.find<AuthRepository>();

  @override
  FutureOr<RepoReponse<User?>> call(String params) {
    return authRepository.fetchUser(params);
  }
}
