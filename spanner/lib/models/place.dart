import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spanner/models/geometry.dart';

class Places {
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;
  final Geometry geometry;

  Places(
      {required this.geometry,
      required this.name,
      required this.userRatingCount,
      required this.rating,
      required this.vicinity});

  Places.fromJson(
    Map<dynamic, dynamic> parsedJson,
  )   : name = parsedJson["name"],
        rating = (parsedJson["rating"] != null)
            ? parsedJson["rating"].toDouble()
            : null,
        userRatingCount = (parsedJson["user_ratings_total"] != null)
            ? parsedJson["user_ratings_total"]
            : null,
        vicinity = parsedJson["vicinity"],
        geometry = Geometry.fromJson(parsedJson["geometry"]);
}
