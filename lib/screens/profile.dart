import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTabBodyWidget extends StatelessWidget {
  const ProfileTabBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getUser(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        } else {
          var profile = snapshot.data!.docs.first;
          return Container(
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
      
                      Padding(
                        padding: EdgeInsets.all(10), 
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                          ),
                          width: double.infinity, 
                          child: Text("NAME: ${profile['name']}"))
                      ),
      
                      Padding(
                        padding: EdgeInsets.all(10), 
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                          ),
                          width: double.infinity, 
                          child: Text("EMAIL: ${profile['email']}"))
                      ),

                      Padding(
                        padding: EdgeInsets.all(10), 
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                          ),
                          width: double.infinity, 
                          child: Text("USER TYPE: ${profile['userType']}"))
                      ),

                      Padding(
                        padding: EdgeInsets.all(10), 
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                          ),
                          width: double.infinity, 
                          child: Text("User Since: ${profile['dateCreated']}"))
                      ),
      
                      ],
                  ),)), 
          );
        }
      }
    );
  } 
}

Future<QuerySnapshot> getUser() async {
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString().trim();
  print(userEmail);
  return await FirebaseFirestore.instance
            .collection("users")
            .where('email', isEqualTo: userEmail)
            .get();
}