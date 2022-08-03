import 'package:adoption_hero/models/userProfileDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileWidget extends StatefulWidget {

  UserProfileDTO userProfile;

  EditProfileWidget({Key? key, required this.userProfile}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  
  String? name;
  String? email;
  String? userType;
  late String dropdownValue = widget.userProfile.userType;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Icon(Icons.pets_rounded),
        backgroundColor: Colors.green[100],
      ),
      body: Form(
        key: formKey,
        child: Container(
          constraints: BoxConstraints.expand(),
          padding: const EdgeInsets.all(8.0),
          color: Colors.green[50],
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
          
                    Padding(
                    padding: EdgeInsets.all(10), 
                    child: Container(
                      height: 350, width: double.infinity, 
                      child: Image.asset('assets/images/clown.jpg'))
                    ),
          
                    editNameField(),
                    editEmailField(),
                    Container(
                      height: 10,
                    ),
                    accountTypeDropdown(),
                    uploadButton(context),
                  ],
                ),
              )
            ), 
        ),
      ),
    );
  }

  Widget editNameField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        initialValue: widget.userProfile.name,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Edit Name',
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Please enter a name';
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

  Widget editEmailField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        initialValue: widget.userProfile.email,
        decoration: InputDecoration(
          labelText: 'Edit Email',
          hintText: widget.userProfile.email
        ),
        validator: (value) {
          if(value!.isEmpty || !value.contains('@')){
            return 'Please enter a valid email address';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          email = widget.userProfile.email;
        }
      )
    );
  }

  Widget accountTypeDropdown() {
    return DropdownButtonFormField (
      style: const TextStyle(color: Colors.black),
      value: widget.userProfile.userType,
      icon: const Icon(Icons.arrow_downward),
      decoration: const InputDecoration(
          labelText: "Account Type",
          border: OutlineInputBorder()
      ),
      items: <String>["Admin", "User"]
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.toString())
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

  Widget uploadButton(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          uploadData();
          Navigator.popAndPushNamed(
            context, 'home'
          );
        }
      }, 
      child: const Text('Save changes'),
    );
  }

  void uploadData() async {
    FirebaseFirestore.instance
      .collection('users')
      .doc(widget.userProfile.docId)
      .update({
        'name': name,
        'email': email,
        'userType': userType
      }
    );
  }
}