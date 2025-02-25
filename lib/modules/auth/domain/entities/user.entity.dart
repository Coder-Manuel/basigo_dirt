import 'package:basigo_dirt/core/enums/auth.enum.dart';

class User {
  final String id;
  final String name;
  final UserRole role;
  final DateTime? createdAt;

  User({
    required this.id,
    required this.name,
    required this.role,
    this.createdAt,
  });
}
