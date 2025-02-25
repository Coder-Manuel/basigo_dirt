import 'dart:convert';

import 'package:basigo_dirt/modules/incident/domain/entities/location.entity.dart';

class LocationModel extends Location {
  LocationModel({
    String? address,
    required super.lat,
    required super.long,
  }) : super(address: address ?? 'NA');

  static LocationModel nan = LocationModel(lat: 0, long: 0);

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        address: map['address'],
        lat: map['lat'] ?? 0.0,
        long: map['long'] ?? 0.0,
      );

  Map<String, dynamic> get toMap => {
        'address': address,
        'lat': lat,
        'long': long,
      };

  String get toJson => jsonEncode(toMap);

  factory LocationModel.fromJson(String jsonString) => LocationModel.fromMap(
        jsonDecode(jsonString),
      );

  factory LocationModel.fromEntity(Location entity) => LocationModel(
        address: entity.address,
        lat: entity.lat,
        long: entity.long,
      );
}
