import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';

class AddPetTabBodyWidget extends StatelessWidget {
  const AddPetTabBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: 
      Column(
        children: [

        const Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Pet Name'),
        )),
        
        const Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Description', 
              //border: OutlineInputBorder(), 
              contentPadding: EdgeInsets.symmetric(vertical: 20.0),),
        )),

        RaisedButton(
          onPressed: () {},
          child: Text('Save Entry')
        )
        ])
    );
  } 
}