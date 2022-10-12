import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:spanner/models/place.dart';
import 'package:spanner/screens/diagnosis.dart';
import 'package:spanner/screens/search.dart';
import 'package:spanner/services/geolocator_service.dart';
import 'package:spanner/services/places_services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Places>>>(
          update: (context, position, places) {
            return;
          },
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Diagnosis(),
          '/search': (context) => const Search(),
        },
      ),
    );
  }
}
