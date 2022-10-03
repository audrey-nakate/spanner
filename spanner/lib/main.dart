import 'package:flutter/material.dart';
import 'package:spanner/pages/diagnosis.dart';
import 'package:spanner/pages/search.dart';

void main() {
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
