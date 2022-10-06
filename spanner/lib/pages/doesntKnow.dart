import 'package:flutter/material.dart';
import 'problem.dart';

List<String> possibleProblems = [
  'Problem 1',
  'Problem 2',
  'Problem 3',
  'Problem 4',
  'Problem 5',
];

class doesntKnow extends StatefulWidget {
  const doesntKnow({super.key});

  @override
  State<doesntKnow> createState() => _doesntKnowState();
}

class _doesntKnowState extends State<doesntKnow> {
  String dropDownValue = possibleProblems.first;
  Problem problem = Problem();
  final _form2Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Builder(
            builder: ((context) => Form(
                  key: _form2Key,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Car Model:'),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Name your Car Model',
                            border: OutlineInputBorder(),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please name your car model';
                            }
                            return null;
                          }),
                          onSaved: (value) => problem.carModel = value!,
                        ),
                        const SizedBox(height: 5.0),
                        const Text('Choose a possible problem:'),
                        // Dropdown menu code
                        DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            value: dropDownValue,
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (String? value) {
                              setState(() {
                                dropDownValue = value!;
                              });
                            },
                            items: possibleProblems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onSaved: (value) => problem.description = value!),
                        // Submitting button
                        Center(
                          child: ElevatedButton(
                              child: const Text('Submit'),
                              onPressed: () {
                                final form = _form2Key.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  _showDialog(context);
                                  Navigator.pushNamed(context, '/search',
                                      arguments: {
                                        'carModel': problem.carModel,
                                        'description': problem.description,
                                      });
                                }
                              }),
                        ),
                      ],
                    ),
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
