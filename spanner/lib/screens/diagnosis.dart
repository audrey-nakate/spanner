import 'package:flutter/material.dart';

class Diagnosis extends StatefulWidget {
  const Diagnosis({super.key});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  //keeps track of what the user has typed into the text field
  final _textController = TextEditingController();

  // Variable to store user problem
  late String userProblem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spanner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Input your problem:',
            ),
            const SizedBox(height: 5.0),
            // where user inputs text
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Describe your problem',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: (() {
                      _textController.clear();
                    }),
                    icon: const Icon(Icons.clear)),
              ),
            ),
            Center(
                child: MaterialButton(
                    onPressed: (() {
                      userProblem = _textController.text;
                      Navigator.pushNamed(context, '/search');
                    }),
                    color: Colors.grey,
                    child: const Text('Submit')))
          ],
        ),
      ),
    );
  }
}
