import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class mechanicspage extends StatefulWidget{
  @override
  _mechanicspageState createState() => _mechanicspageState();
}

class _mechanicspageState extends State<mechanicspage>{
  final Stream<QuerySnapshot>_usersStream =FirebaseFirestore.instance
  .collection('users')
  .where('category',isEqualTo: 'Mechanic')
  .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details')
      ));
  }   
}