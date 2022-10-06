import 'package:flutter/material.dart';
import 'doesntKnow.dart';
import 'problem.dart';

Problem problem = Problem();

Widget createWidget(int count) {
  final _formKey = GlobalKey<FormState>();
  print('inside createWidget');
  if (count == 1) {
    print(count);
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Builder(
        builder: ((context) => Form(
              key: _formKey,
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
                      }),
                      onSaved: (value) => problem.carModel = value!,
                    ),
                    const SizedBox(height: 5.0),
                    const Text('Problem Description:'),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Describe your problem',
                        border: OutlineInputBorder(),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe your problem';
                        }
                      }),
                      onSaved: (value) => problem.description = value!,
                    ),
                    Center(
                      child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            final form = _formKey.currentState;
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
            )),
      ),
    );
  } else if (count == 2) {
    print(count);
    return const doesntKnow();
  }
  return Container();
}

_showDialog(BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Saving Information')));
}
