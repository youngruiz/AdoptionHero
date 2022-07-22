import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddPetTabBodyWidget extends StatefulWidget {
  const AddPetTabBodyWidget({Key? key}) : super(key: key);

  @override
  State<AddPetTabBodyWidget> createState() => _AddPetTabBodyWidgetState();
}

class _AddPetTabBodyWidgetState extends State<AddPetTabBodyWidget> {
  
  final formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: 
      Form(
        key: formKey,
        child: Column(
          children: [
      
          Padding(
            padding: const EdgeInsets.all(10),
            child: textEntryField('Pet Name')),
          
          const Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Description', 
                //border: OutlineInputBorder(), 
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),),
          )),
      
          // RaisedButton(
          //   onPressed: () {},
          //   child: Text('Choose Photo and Save Entry')
          // )
          selectImageButton()
          ]),
      )
    );
  }

    Widget textEntryField(labelText){
      return TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: labelText),
      );
    }

    Future getImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      image = File(pickedFile!.path);
      var fileName = '${DateTime.now()}.jpg';
      Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(image!);
      await uploadTask;
      final url = await storageReference.getDownloadURL();
      return url;
    }

   void uploadData() async {
    final url = await getImage();
    FirebaseFirestore.instance
      .collection('pets')
      .add({
        'name': "Fido",
        'type': "Dog",
        'breed': "Retriever",
        'disposition': "Chill",
        'availability': "Available Now",
        'description': "Chill AF",
        'userId': "userID1234567",
        'imgUrl': url,
        'liked': 0,
        'dateCreated': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        'newsItem': "NEWS"
      });
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

