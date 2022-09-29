import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  getLocation() async {
    var geolocator = Geolocator();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
