import 'package:spanner/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyAHFbQDh_WPeCEaheOG8hwgri-XyOTCYNE';

  Future<List<Places>> getPlaces(
    double lat,
    double lng,
  ) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=car_repair&rankby=distance&key=$key'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Places.fromJson(place)).toList();
  }
}
