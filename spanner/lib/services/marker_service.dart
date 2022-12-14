import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spanner/models/place.dart';

class MarkerService {
  List<Marker> getMarkers(List<Places> places) {
    var markers = <Marker>[];

    for (var place in places) {
      Marker marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng));

      markers.add(marker);
    }

    return markers;
  }
}
