
import 'package:adoption_hero/screens/pet_view.dart';
import 'package:adoption_hero/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/pets.dart';
import 'screens/news.dart';
import 'screens/add_pet.dart';
import 'screens/news_article.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

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


  static const String _title = 'Flutter Code Sample';
  // initialRoute = '/';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      routes: routes,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    LoginWidget(),
    Pets(),
    News(),
    AddPetTabBodyWidget(),
    ProfileTabBodyWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Icon(Icons.pets_rounded),
        backgroundColor: Colors.green[100],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
            backgroundColor: Colors.grey[350],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pets',
            backgroundColor: Colors.grey[350],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.grey[350],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Pet',
            backgroundColor: Colors.grey[350],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.grey[350],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
