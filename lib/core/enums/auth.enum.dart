enum UserRole { driver, dispatch }

extension UserRoleExt on UserRole {
  bool get isDriver => this == UserRole.driver;
}
