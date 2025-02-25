import 'package:basigo_dirt/core/types/repo_reponse.type.dart';
import 'package:basigo_dirt/core/utils/error_util/error_wrapper.dart';
import 'package:basigo_dirt/modules/auth/data/sources/local_auth.dts.dart';
import 'package:basigo_dirt/modules/auth/data/sources/remote_auth_dts.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:basigo_dirt/modules/auth/domain/repositories/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String _library = 'Auth Repository';
  final RemoteAuthDataSource remoteAuthDTS;
  final LocalAuthDataSource localAuthDTS;

  AuthRepositoryImpl({required this.remoteAuthDTS, required this.localAuthDTS});

  @override
  User? get currentUser {
    final remoteUser = remoteAuthDTS.currentUser;
    if (remoteUser == null) return null;
    return localAuthDTS.currentUser;
  }

  @override
  Future<RepoReponse<User?>> fetchUser(String id) async {
    final response = await ErrorWrapper.async<RepoReponse<User?>>(
      () async {
        final user = await remoteAuthDTS.fetchUserById(id);
        return SuccessResponse(user);
      },
      onError: (_) => FailureResponse('An error occured, Kindly Retry'),
      library: _library,
      description: 'while fetching user by id',
    );

    return response!;
  }

  @override
  Future<RepoReponse<User>> login({
    required String email,
    required String password,
  }) async {
    final response = await ErrorWrapper.async<RepoReponse<User>>(
      () async {
        final res = await remoteAuthDTS.login(email: email, password: password);
        if (res.user == null) {
          return FailureResponse('Credentials Invalid');
        }

        final user = await remoteAuthDTS.fetchUserById(res.user!.uid);
        if (user == null) {
          return FailureResponse('User details not found');
        }

        localAuthDTS.saveUser(user);
        return SuccessResponse(user);
      },
      onError: (e) {
        if (e.toString().contains('invalid-credential')) {
          return FailureResponse(
            'Invalid credentials, counter-check details and retry',
          );
        }

        return FailureResponse('An error occurred, Kindly Retry');
      },
      library: _library,
      description: 'while loggin user',
    );

    return response!;
  }
}
