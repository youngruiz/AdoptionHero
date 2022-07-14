import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';

class PetsTabBodyWidget extends StatelessWidget {
  const PetsTabBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: <Widget>[
           Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("PET 1"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text("PET 2"),
          ),
      ],);
  } 
}