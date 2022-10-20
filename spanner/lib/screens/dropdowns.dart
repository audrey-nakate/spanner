import 'package:flutter/material.dart';
import '../models/lists_and_classes.dart';

Problem problem = Problem();

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  String? _brandSelection;
  String? _modelSelection;
  List<String> selectedCarModels = [];
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonFormField(
              isExpanded: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Car Brand'),
              value: _brandSelection,
              onChanged: (newValue) async {
                setState(() {
                  _modelSelection = null;
                  selectedCarModels = [];
                  _brandSelection = newValue!;
                  selectedCarModels = carInfo
                      .where((c) =>
                          c['brand'] ==
                          newValue) //where allows you to filter out values based on certain conditions
                      .first['models'] as List<String>;
                  print(_brandSelection);
                });
              },
              items: carInfo.map<DropdownMenuItem<String>>((Map map) {
                return DropdownMenuItem(
                  value: map["brand"].toString(),
                  child: Text(
                    map["brand"],
                  ),
                );
              }).toList(),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please pick a car model';
                }
              }),
              onSaved: (value) => problem.carBrand = value!),
        ),
      ),
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonFormField(
            isExpanded: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Car Model'),
            onChanged: (newValue) {
              setState(() {
                _modelSelection = newValue!;
                print(_modelSelection);
              });
            },
            value: _modelSelection,
            items:
                selectedCarModels.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return 'Please pick a car model';
              }
            }),
            onSaved: (value) => problem.carModel = value!,
          ),
        ),
      ),
    ]);
  }
}

class ProblemsDropdown extends StatefulWidget {
  const ProblemsDropdown({super.key});

  @override
  State<ProblemsDropdown> createState() => _ProblemsDropdownState();
}

class _ProblemsDropdownState extends State<ProblemsDropdown> {
  String dropDownValue = possibleProblems.first;
  Problem problem = Problem();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
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
          items: possibleProblems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onSaved: (value) => problem.possibleProblem = value!),
    );
  }
}
