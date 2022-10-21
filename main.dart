import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'firebase_options.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: 
   DefaultFirebaseOptions.currentPlatform);
   runApp(Spanner());
  }

 class Spanner extends StatefulWidget {
  @override
  _SpannerState createState() => _SpannerState();
}

class _SpannerState extends State<Spanner> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor:const Color.fromARGB(255, 0, 203, 230), 
      ),
      home: Register(),
    );
  }
}

