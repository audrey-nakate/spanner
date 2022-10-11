import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:image_picker/image_picker.dart';
import 'lists_and_classes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

Problem problem = Problem();

class Diagnosis extends StatefulWidget {
  const Diagnosis({super.key});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  final _formKey = GlobalKey<FormState>();
  final modelSelected = TextEditingController();

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
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          //Dropdown menu of car models. To be updated to a better version
                          child: DropDownField(
                            itemsVisibleInDropdown: 3,
                            controller: modelSelected,
                            hintText: 'Select a model',
                            enabled: true,
                            items: models,
                            onValueChanged: ((value) {
                              setState(() {
                                problem.carModel = value;
                              });
                            }),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Year',
                              border: OutlineInputBorder(),
                            ),
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input a year.';
                              }
                            }),
                            onSaved: (value) => problem.carYear = value!,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text('Checkout possible problems:'),
                  ),
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
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe your problem';
                        }
                      }),
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
                            _showDialog(context);
                            Navigator.pushNamed(context, '/search', arguments: {
                              'carModel': problem.carModel,
                              'description': problem.description,
                            });
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

class ProblemsDropdown extends StatefulWidget {
  const ProblemsDropdown({super.key});

  @override
  State<ProblemsDropdown> createState() => _ProblemsDropdownState();
}

class _ProblemsDropdownState extends State<ProblemsDropdown> {
  String dropDownValue = possibleProblems.first;
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
          onSaved: (value) => problem.description = value!),
    );
  }
}

class ImageHandler extends StatefulWidget {
  const ImageHandler({super.key});

  @override
  State<ImageHandler> createState() => _ImageHandlerState();
}

class _ImageHandlerState extends State<ImageHandler> {
  String? imageUrl;

  //Initializing plugin instances
  carImageUpload(source) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    File? image;

    //To get permissions from device
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      final image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        var file = File(image.path);
        final String picture =
            '1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        //Upload to firebase
        UploadTask task = _firebaseStorage.ref().child(picture).putFile(file);

        TaskSnapshot snapshot = await task;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No image path received');
      }
    } else {
      print('Access denied, try again after allowing access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: (imageUrl != null)
                  ? Image.network(imageUrl!)
                  : Image.network('https://i.imgur.com/sUFH1Aq.png')),
          //To choose where to get the image from.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: const Text('Camera'),
                onPressed: () {
                  carImageUpload(ImageSource.camera);
                },
              ),
              ElevatedButton(
                child: const Text('Gallery'),
                onPressed: () {
                  carImageUpload(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Problem problem = Problem();

// class Diagnosis extends StatefulWidget {
//   const Diagnosis({super.key});

//   @override
//   State<Diagnosis> createState() => _DiagnosisState();
// }

// class _DiagnosisState extends State<Diagnosis> {
//   int _count = -1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Spanner'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 padding: const EdgeInsets.all(10.0),
//                 child: const Center(
//                     child: Text('Can you describe your problem?'))),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 TextButton(
//                     child: const Text('Yes'),
//                     onPressed: () {
//                       setState(() {
//                         _count = 1;
//                       });
//                     }),
//                 TextButton(
//                     child: const Text('No'),
//                     onPressed: () {
//                       setState(() {
//                         _count = 2;
//                       });
//                     }),
//               ],
//             ),
//             const SizedBox(height: 5.0),
//             SizedBox(height: 300.0, child: createWidget(_count)),
//           ],
//         ),
//       ),
//     );
//   }
// }
