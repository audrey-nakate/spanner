import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spanner/models/place.dart';
import 'package:spanner/services/geolocator_service.dart';
import 'package:spanner/services/marker_service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

// //what our search screen will lool like
// class Search extends StatelessWidget {
//   const Search({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: <Widget>[
//         SizedBox(
//             height: MediaQuery.of(context).size.height / 3,
//             width: MediaQuery.of(context).size.width,
//             child: const GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: LatLng(0.7558, 33.4384), zoom: 16.0),
//               zoomGesturesEnabled: true,
//             ))
//       ],
//     ));
//   }
// }
class Search extends StatefulWidget {
  //UsersGeoPage({super.key});

  late double _initRadius;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with WidgetsBindingObserver {
  // String _platformVersion = Platform.isAndroid ? "Android" : "ios";

  static LatLng _initialPosition = LatLng(0, 0);

  Completer<GoogleMapController> _controller = Completer();
  final _formkey = GlobalKey<FormState>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String event = "";
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _initPlatformState();

    // _listenForPersmissionStatus();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // var initializationSettingsIOS = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //onDidReceiveNotificationResponse: null,
    );
  }

  @override
  void didUpdateWidget(Search oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("oldwidget $oldWidget");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        // _listenForPersmissionStatus();
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.inactive:
        print("inactive");

        setState(() {});
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      default:
        print("Lifecycle error occur");
    }
  }

  // Future<void> _listenForPersmissionStatus() async {
  //   try {
  //     final _status = await Permission.locationWhenInUse.serviceStatus;

  //     if (_status.isEnabled) {
  //       print("permission granted");

  //     } else {
  //       print("permission denied");
  //     }
  //   } catch (error) {
  //     print("get permission status error: $error");
  //   }
  // }

  Future<void> _initPlatformState() async {
    if (!mounted) return;

    setState(() {});
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Open Map to Navigate to Centre"),
        content: Text("Playload : $payload"),
      ),
    );
  }

  void _scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        // 'Spanner App',
        icon: "@mipmap/ic_launcher",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      // var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        // iOS: iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        subtitle,
        platformChannelSpecifics,
        payload: 'you clicked the notfication',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //these variables help us to pass functions of services into the Search class
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Places>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      initialData: 'loading map ....',
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
                          Container(
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
                              padding: const EdgeInsets.only(
                                top: 210.0,
                              ),
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
                                          initialData: null,
                                          child: GestureDetector(
                                            onTap: () {
                                              _scheduleNotification(
                                                  'The Mechanic Has Been Notified',
                                                  'At the $places[index].name');
                                            },
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
                                                    (places[index].rating !=
                                                            null)
                                                        ? Row(children: [
                                                            RatingBarIndicator(
                                                              rating:
                                                                  places[index]
                                                                      .rating,
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              itemCount: 5,
                                                              itemSize: 10.0,
                                                              direction: Axis
                                                                  .horizontal,
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
                                          ),
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
