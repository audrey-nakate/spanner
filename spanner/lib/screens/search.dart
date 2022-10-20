import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spanner/models/place.dart';
import 'package:spanner/services/geolocator_service.dart';
import 'package:spanner/services/marker_service.dart';
import 'package:url_launcher/url_launcher.dart';

//this is the layout of the map page
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    //these variables help us to pass functions of services into the Search class
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Places>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
          //give each place a marker
          body: (currentPosition != null)
              ? Consumer<List<Places>>(builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : <Marker>[];
                  return (places != null)
                      ? Column(children: <Widget>[
                          //adding the google map
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(currentPosition.latitude,
                                      currentPosition.longitude),
                                  zoom: 16.0),
                              zoomGesturesEnabled: true,
                              markers: Set<Marker>.of(markers),
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: true,
                              padding: const EdgeInsets.only(top: 210.0),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          //scrollable list of nearby services
                          Expanded(
                              child: placesProvider == null
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : ListView.builder(
                                      itemCount: places.length,
                                      itemBuilder: (context, index) {
                                        //provinding distance of services from user
                                        return FutureProvider(
                                          create: (context) =>
                                              geoService.getDistance(
                                                  currentPosition.latitude,
                                                  currentPosition.longitude,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng),
                                          child: Card(
                                              child: ListTile(
                                            title: Text(places[index].name),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  const SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  (places[index].rating != null)
                                                      ? Row(children: [
                                                          RatingBarIndicator(
                                                            rating:
                                                                places[index]
                                                                    .rating,
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 10.0,
                                                            direction:
                                                                Axis.horizontal,
                                                          )
                                                        ])
                                                      : Row(),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Consumer<double>(
                                                    builder: (context, meters,
                                                        widget) {
                                                      return (meters != null)
                                                          ? Text(
                                                              '${places[index].vicinity} \u00b7 ${(meters.round())} m')
                                                          : Container();
                                                    },
                                                  )
                                                ]),
                                            //adding button to take us to directions
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.directions,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              onPressed: () {
                                                _launchMapsUrl(
                                                    places[index]
                                                        .geometry
                                                        .location
                                                        .lat,
                                                    places[index]
                                                        .geometry
                                                        .location
                                                        .lng);
                                              },
                                            ),
                                          )),
                                        );
                                      },
                                    ))
                        ])
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                })
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
