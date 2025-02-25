import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';
import 'package:get/get.dart';

class CurrentUserUseCase {
  final authRepository = Get.find<AuthRepository>();

  User? get user => authRepository.currentUser;
}
