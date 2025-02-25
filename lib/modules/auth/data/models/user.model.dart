import 'dart:convert';

import 'package:basigo_dirt/core/enums/auth.enum.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';

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

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'role': role.name,
        'createdAt': createdAt?.toIso8601String(),
      };

  String get toJson => jsonEncode(toMap);

  factory UserModel.fromJson(String jsonString) => UserModel.fromMap(
        jsonDecode(jsonString),
      );
}
