import 'dart:io';
import 'package:adoption_hero/screens/navigator_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';




class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  
  final user = FirebaseAuth.instance.currentUser!;
  final formKey = GlobalKey<FormState>();
  String dropdownValue = "User";
  File? image;
  final picker = ImagePicker();

  String? name;
  String? email;
  String? userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Icon(Icons.pets_rounded),
        backgroundColor: Colors.green[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: 
        Form(
          key: formKey,
          child: Column(
            children: [
              userNameField(),
              accountTypeDropdown(),
              selectImageButton(),
            ]),
        )
      ),
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
      .collection('users')
      .add({
        'name': name,
        'email': user.email!,
        'userType': userType,
        'imgUrl': url,
        'dateCreated': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      });
  }

  Widget selectImageButton() {
    return ElevatedButton(
      child: const Text("Choose photo and create account"),
      onPressed: () async {
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          uploadData();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigatorScaffold()));
        }
      },
    );
  }

  Widget userNameField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Name'
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Name cannot be empty';
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

  Widget accountTypeDropdown() {
    return DropdownButtonFormField (
      style: const TextStyle(color: Colors.black),
      value: "User",
      icon: const Icon(Icons.arrow_downward),
      decoration: const InputDecoration(
          labelText: "Account Type",
          border: OutlineInputBorder()
      ),
      items: <String>["Admin", "User"]
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value)
        );
      }).toList(), 
      onChanged: (value) {
        setState((){
          dropdownValue = value.toString();
        });
      },
      onSaved: (value) {
        userType = value.toString();
      },
    );
  }
}