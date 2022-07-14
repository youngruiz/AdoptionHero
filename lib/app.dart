import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/db_test.dart';

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
            title: 'Flutter Demo',
            home: MyHomePage(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String widgetTitle = 'Title';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widgetTitle)),
      body: const DbTest()
    );
  }
}