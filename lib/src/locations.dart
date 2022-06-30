import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'locations.g.dart';

/// A simple class meant to store latitude and longitude values for use in the
/// GoogleMap widget.
@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

/// A simple class for storing a single food truck's information that will
/// be displayed in a dialog popup, and more.
@JsonSerializable()
class Truck {
  Truck({
    required this.email,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.state,
    required this.city,
    required this.url,
    required this.type,
    required this.description,
  });

  factory Truck.fromJson(Map<String, dynamic> json) => _$TruckFromJson(json);
  Map<String, dynamic> toJson() => _$TruckToJson(this);

  final String email;
  final int id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String state;
  final String city;
  final String url;
  final String type;
  final String description;
}

/// A simple class for storing all the food trucks' information for
/// creating map markers and providing info to dialog popups.
@JsonSerializable()
class Locations {
  Locations({
    required this.trucks,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Truck> trucks;
}

/// Returns the information of all the food trucks.
Future<Locations> getFoodTrucks() async {
  // The URL for retrieving all the data for the food trucks.
  const truckLocationsURL =
      'https://food-truck-c9344-default-rtdb.firebaseio.com/trucks.json';
  // Instance of locations to store info of all trucks.
  late Locations truckLocations;

  // Retrieve the data for the Food trucks.
  try {
    final response = await http.get(Uri.parse(truckLocationsURL));
    if (response.statusCode == 200) {
      truckLocations =
          Locations.fromJson({"trucks": json.decode(response.body)});
    }
    // Fallback for when the above HTTP request fails.
  } catch (e) {
    truckLocations =
        json.decode(await rootBundle.loadString('assets/locations.json'));
  }

  return truckLocations;
}
