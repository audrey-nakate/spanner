// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class ImageHandler extends StatefulWidget {
//   const ImageHandler({super.key});

//   @override
//   State<ImageHandler> createState() => _ImageHandlerState();
// }

// class _ImageHandlerState extends State<ImageHandler> {
//   String? imageUrl;

//   //Initializing plugin instances
//   carImageUpload(source) async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final _imagePicker = ImagePicker();
//     File? image;

//     //To get permissions from device
//     var Permission;
//     await Permission.photos.request();
//     var permissionStatus = await Permission.photos.status;

//     if (permissionStatus.isGranted) {
//       final image = await _imagePicker.getImage(source: source);
//       if (image != null) {
//         var file = File(image.path);
//         final String picture =
//             '1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
//         //Upload to firebase
//         UploadTask task = _firebaseStorage.ref().child(picture).putFile(file);

//         TaskSnapshot snapshot = await task;
//         var downloadUrl = await snapshot.ref.getDownloadURL();
//         setState(() {
//           imageUrl = downloadUrl;
//         });
//       } else {
//         print('No image path received');
//       }
//     } else {
//       print('Access denied, try again after allowing access');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         children: <Widget>[
//           Container(
//               margin: const EdgeInsets.all(15),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(15),
//                 ),
//                 border: Border.all(color: Colors.white),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     offset: Offset(2, 2),
//                     spreadRadius: 2,
//                     blurRadius: 1,
//                   ),
//                 ],
//               ),
//               child: (imageUrl != null)
//                   ? Image.network(imageUrl!)
//                   : Image.network('https://i.imgur.com/sUFH1Aq.png')),
//           //To choose where to get the image from.
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 child: const Text('Camera'),
//                 onPressed: () {
//                   carImageUpload(ImageSource.camera);
//                 },
//               ),
//               ElevatedButton(
//                 child: const Text('Gallery'),
//                 onPressed: () {
//                   carImageUpload(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
