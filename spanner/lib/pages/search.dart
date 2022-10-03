import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

//what our search screen will lool like
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: const GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(0.7558, 33.4384), zoom: 16.0),
              zoomGesturesEnabled: true,
            ))
      ],
    ));
  }
}
