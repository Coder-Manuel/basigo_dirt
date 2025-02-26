import 'dart:convert';

import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.role,
    super.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        name: map['name'],
        role: UserRole.values.firstWhere(
          (v) => map['role'] == v.name,
          orElse: () => UserRole.driver,
        ),
        createdAt: DateTime.tryParse('${map['createdAt']}'),
      );

  factory UserModel.fromEntity(User entity) => UserModel(
        id: entity.id,
        name: entity.name,
        role: entity.role,
        createdAt: entity.createdAt,
      );

  factory UserModel.fromFirebase(auth.User user) => UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        role: UserRole.driver,
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'role': role.name,
      };

  String get toJson => jsonEncode(toMap);

  factory UserModel.fromJson(String jsonString) => UserModel.fromMap(
        jsonDecode(jsonString),
      );
}
