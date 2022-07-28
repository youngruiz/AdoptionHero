import 'package:adoption_hero/screens/news.dart';
import 'package:adoption_hero/screens/news_article.dart';
import 'package:adoption_hero/screens/pet_view.dart';
import 'package:adoption_hero/screens/pets.dart';
import 'package:adoption_hero/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    static final routes = {
        // '/': (context) => const LoginWidget(),
        // '/register': (context) => const RegisterWidget(),
        News.routeName: (context) => News(),
        NewsArticle.routeName: (context) => NewsArticle(),
        Pets.routeName: (context) => Pets(),
        PetView.routeName: (context) => PetView(),
        };

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }

        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Adoption Hero',
            home: RegisterWidget(),
            routes: routes
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}