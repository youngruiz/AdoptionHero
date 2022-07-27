import 'package:adoption_hero/screens/add_pet.dart';
import 'package:adoption_hero/screens/news.dart';
import 'package:adoption_hero/screens/pets.dart';
import 'package:adoption_hero/screens/profile.dart';
import 'package:flutter/material.dart';

class NavigatorScaffold extends StatefulWidget {
  const NavigatorScaffold({Key? key}) : super(key: key);

  @override
  State<NavigatorScaffold> createState() => _NavigatorScaffoldState();
}

class _NavigatorScaffoldState extends State<NavigatorScaffold> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.login),
          //   label: 'Login',
          //   backgroundColor: Colors.grey[350],
          // ),
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