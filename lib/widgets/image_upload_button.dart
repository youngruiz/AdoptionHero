import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/camera_screen.dart';

class ImageUploadButton extends StatefulWidget {
  const ImageUploadButton({ Key? key }) : super(key: key);

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  File? image;
  final picker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    return selectImageButton();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  void uploadData() async {
    final url = await getImage();
    Navigator.of(context)
      .push(
        MaterialPageRoute(builder: (context) => CameraScreen(url: url))
      );
  }

  Widget selectImageButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add_a_photo),
      onPressed: () {
        uploadData();
      },
    );
  }
}