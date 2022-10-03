<<<<<<< HEAD
import 'dart:io';
=======
>>>>>>> dfe83a17c1944b2deacfe50d7ceecb4869436647
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
<<<<<<< HEAD
        body: (currentPosition != null)
            ? Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(currentPosition.latitude,
                                currentPosition.longitude),
                            zoom: 16.0),
                        zoomGesturesEnabled: true,
                      ))
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
=======
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
>>>>>>> dfe83a17c1944b2deacfe50d7ceecb4869436647
  }
}
