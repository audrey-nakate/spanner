import 'package:flutter/material.dart';
import 'package:spanner/pages/diagnosis.dart';
import 'package:spanner/pages/search.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Diagnosis(),
        '/search': (context) => const Search(),
      },
    ),
  );
}
