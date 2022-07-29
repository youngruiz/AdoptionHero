import 'package:flutter/material.dart';

class AddPetNonAdmin extends StatelessWidget {
  const AddPetNonAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Only admins may add new pets."),
        SizedBox(
          height: 350, width: double.infinity, 
          child: Image.asset('assets/images/clown.jpg'))
      ],
    );
  }
}