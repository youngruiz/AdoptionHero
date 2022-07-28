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

  String? name;
  String? type;
  String? breed;
  String? disposition;
  String? availability;
  String? newsItem;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: 
      Form(
        key: formKey,
        child: Column(
          children: [
      
            petNameField(),
            petTypeField(),
            petBreedField(),
            petDispositionField(),
            petAvailabilityField(),
            petDescriptionField(),
            petNewsItemField(),
      
          // RaisedButton(
          //   onPressed: () {},
          //   child: Text('Choose Photo and Save Entry')
          // )
          selectImageButton()
          ]),
      )
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
        'name': name,
        'type': type,
        'breed': breed,
        'disposition': disposition,
        'availability': availability,
        'description': description,
        'userId': "userID1234567",
        'imgUrl': url,
        'liked': 0,
        'dateCreated': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        'newsItem': newsItem
      });
  }

  Widget selectImageButton() {
    return ElevatedButton(
      child: const Text("Choose photo and upload data"),
      onPressed: () async {
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          uploadData();
        }
      },
    );
  }

    Widget petNameField(){
      return Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Pet Name'
          ),
          validator: (value) {
            if(value!.isEmpty){
              return 'Pet Name cannot be empty';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            name = value;
          }
      )
    );
  }

  Widget petTypeField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Pet Type'
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Type cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          type = value;
        }
      )
    );
  }

  Widget petBreedField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Pet Breed'
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Breed cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          breed = value;
        }
      )
    );
  }

  Widget petDispositionField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Pet Disposition'
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Disposition cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          disposition = value;
        }
      )
    );
  }

  Widget petAvailabilityField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Pet Availability'
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Availability cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          availability = value;
        }
      )
    );
  }

  Widget petDescriptionField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'Pet Description',
          contentPadding: EdgeInsets.symmetric(vertical: 20.0)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Description cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          description = value;
        }
      )
    );
  }

    Widget petNewsItemField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'Pet NewsItem',
          contentPadding: EdgeInsets.symmetric(vertical: 20.0)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet NewsItem cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          newsItem = value;
        }
      )
    );
  }
}

