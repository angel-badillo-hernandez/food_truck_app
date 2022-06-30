// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Truck _$TruckFromJson(Map<String, dynamic> json) => Truck(
      email: json['email'] as String,
      id: json['id'] as int,
      image: json['image'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      url: json['url'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TruckToJson(Truck instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'image': instance.image,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'phone': instance.phone,
      'state': instance.state,
      'city': instance.city,
      'url': instance.url,
      'type': instance.type,
      'description': instance.description,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      trucks: (json['trucks'] as List<dynamic>)
          .map((e) => Truck.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'trucks': instance.trucks,
    };
