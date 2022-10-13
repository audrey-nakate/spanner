import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  final geoLocator = Geolocator();

  Future<Position> getLocation() async {
    return await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location);
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return await geoLocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
