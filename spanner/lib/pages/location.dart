//dummy file to represent where to route after the problem is entered
import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(child: Text('choosing location of user')));
  }
}
