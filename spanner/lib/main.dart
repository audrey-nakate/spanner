import 'package:flutter/material.dart';
import 'package:spanner/pages/diagnosis.dart';
import 'package:spanner/pages/location.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Diagnosis(),
        '/location': (context) => const Location(),
      },
    ),
  );
}
