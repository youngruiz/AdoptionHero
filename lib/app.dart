import 'package:adoption_hero/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }

        if(snapshot.connectionState == ConnectionState.done){
          return const MaterialApp(
            title: 'Adoption Hero',
            home: RegisterWidget(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}