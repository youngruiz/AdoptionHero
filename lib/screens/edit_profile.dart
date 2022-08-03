import 'package:adoption_hero/models/userProfileDTO.dart';
import 'package:adoption_hero/screens/profile.dart';
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
          
                    Padding(
                      padding: EdgeInsets.all(10), 
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                        ),
                        width: double.infinity, 
                        child: Text("USER TYPE: ${widget.userProfile.userType}"))
                    ),
      
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
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Edit Name',
          hintText: widget.userProfile.name
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Please enter a new name';
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
        decoration: InputDecoration(
          labelText: 'Edit Email',
          hintText: widget.userProfile.email
        ),
        validator: (value) {
          if(value!.isEmpty){
            return null;
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

  Widget uploadButton(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          uploadData();
          Navigator.pop(context);
        }
      }, 
      child: const Text('Upload'),
    );
  }

  void uploadData() async {
    FirebaseFirestore.instance
      .collection('users')
      .doc(widget.userProfile.docId)
      .update({
        'name': name,
        'email': email
      }
    );
  }
}