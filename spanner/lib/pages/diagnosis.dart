import 'package:flutter/material.dart';
import 'problem.dart';
import 'create_widget.dart';

Problem problem = Problem();

class Diagnosis extends StatefulWidget {
  const Diagnosis({super.key});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  int _count = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Spanner'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                child: const Center(
                    child: Text('Can you describe your problem?'))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      setState(() {
                        _count = 1;
                      });
                    }),
                TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      setState(() {
                        _count = 2;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 5.0),
            SizedBox(height: 300.0, child: createWidget(_count)),
          ],
        ),
      ),
    );
  }
}
