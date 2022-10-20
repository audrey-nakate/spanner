import 'package:flutter/material.dart';
import '../models/lists_and_classes.dart';
import 'dropdowns.dart';
import 'image_handler.dart';

Problem problem = Problem();

class Diagnosis extends StatefulWidget {
  const Diagnosis({super.key});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Spanner'),
        centerTitle: true,
      ),
      body: Builder(
        builder: ((context) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CarInfo(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text('Checkout possible problems:'),
                  ),
                  const SizedBox(height: 8.0),
                  const ProblemsDropdown(),

                  //Text field to describe the problems
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text('Problem Description:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Is your problem not listed?',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => problem.description = value!,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text(
                        'Provide an image of the car or where the problem is:'),
                  ),
                  //This holds the image and the placeholder if there is no image
                  const ImageHandler(),
                  Center(
                    child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            Navigator.pushNamed(context, '/search', arguments: {
                              'carModel': problem.carModel,
                              'description': problem.description,
                            });
                            _showDialog(context);
                          }
                        }),
                  ),
                ],
              ),
            ))),
      ),
    );
  }

  _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saving Information')));
  }
}
