import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<Position> getLocation() async {
    var geoLocator = Geolocator();
    return await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location);
  }
}
