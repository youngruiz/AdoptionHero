import 'package:adoption_hero/screens/add_pet.dart';
import 'package:adoption_hero/screens/add_pet_nonadmin.dart';
import 'package:adoption_hero/screens/login.dart';
import 'package:adoption_hero/screens/news.dart';
import 'package:adoption_hero/screens/pets.dart';
import 'package:adoption_hero/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adoption_hero/main.dart';

import '../app.dart';

class NavigatorScaffold extends StatefulWidget {
  const NavigatorScaffold({Key? key}) : super(key: key);

  @override
  State<NavigatorScaffold> createState() => _NavigatorScaffoldState();
}

class _NavigatorScaffoldState extends State<NavigatorScaffold> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptionsAdmin = <Widget>[
    Pets(),
    News(),
    AddPetTabBodyWidget(),
    ProfileTabBodyWidget(),
  ];

  static const List<Widget> _widgetOptionsUser = <Widget>[
    Pets(),
    News(),
    ProfileTabBodyWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getUser(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        } else {
          var _widgetOptions = (snapshot.data!.docs.first['userType'] == "Admin") ? _widgetOptionsAdmin : _widgetOptionsUser;
          if (_widgetOptions == _widgetOptionsAdmin){ 
          return Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginWidget()));
                  }),
              title: const Icon(Icons.pets_rounded),
              backgroundColor: Colors.green[100],
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
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

          else {
            return Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginWidget()));
                  }),
              title: const Icon(Icons.pets_rounded),
              backgroundColor: Colors.green[100],
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
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
      }
    );
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  print("logged out");
}

Future<QuerySnapshot> getUser() async {
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString().trim();
  print(userEmail);
  return await FirebaseFirestore.instance
            .collection("users")
            .where('email', isEqualTo: userEmail)
            .get();
}