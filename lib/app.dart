import 'package:adoption_hero/screens/login_register/login.dart';
import 'package:adoption_hero/screens/navigator_scaffold.dart';
import 'package:adoption_hero/screens/news/news.dart';
import 'package:adoption_hero/screens/news/news_article.dart';
import 'package:adoption_hero/screens/pets/pet_view.dart';
import 'package:adoption_hero/screens/pets/pets.dart';
import 'package:adoption_hero/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    static final routes = {
      // '/': (context) => const LoginWidget(),
      // '/register': (context) => const RegisterWidget(),
      News.routeName: (context) => const News(),
      NewsArticle.routeName: (context) => NewsArticle(),
      Pets.routeName: (context) => const Pets(),
      PetView.routeName: (context) => PetView(),
      ProfileTabBodyWidget.routeName: (context) => const ProfileTabBodyWidget(),
      NavigatorScaffold.routeName: (context) => const NavigatorScaffold(),
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
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.data == null){
                  return MaterialApp(
                    title: 'Adoption Hero',
                    home: const LoginWidget(),
                    routes: routes
                  );
                }
                return MaterialApp(
                  title: 'Adoption Hero',
                  home: const NavigatorScaffold(),
                  routes: routes
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}