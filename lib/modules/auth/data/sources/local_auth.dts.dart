import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:hive/hive.dart';

abstract class LocalAuthDataSource {
  Future<void> saveUser(UserModel user);
  UserModel? get currentUser;
}

class LocalAuthDTSImpl extends LocalAuthDataSource {
  late Box<String> userBox;

  LocalAuthDTSImpl();

  Future<LocalAuthDTSImpl> init() async {
    userBox = await Hive.openBox('user');
    return this;
  }

  @override
  UserModel? get currentUser {
    final json = userBox.get('currentUser');
    if (json != null && json.isNotEmpty) {
      return UserModel.fromJson(json);
    }

    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await userBox.clear();
    return userBox.put('currentUser', user.toJson);
  }
}
