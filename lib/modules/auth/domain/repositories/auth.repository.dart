import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';

abstract class AuthRepository {
  Future<RepoReponse<User>> login({
    required String email,
    required String password,
  });
  Future<RepoReponse<User?>> fetchUser(String id);
  Future<RepoReponse<void>> logout();
  User? get currentUser;
}
