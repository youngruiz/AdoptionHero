import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';
import 'pet_view.dart';

class Pets extends StatelessWidget {
  const Pets({Key? key}) : super(key: key);
  
  static const routeName = 'pets';

  @override
  Widget build(BuildContext context) {

    final pets = List<Map>.generate(40, (i) {
        return {
          'pet_name': 'Pet name $i'
        };
    });

    return GridView.builder(
      padding: EdgeInsets.only(top: 5),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ),
      itemCount: pets.length, 
      itemBuilder: (context, index) {

        return Card(
          color: Colors.teal[100],
          child: InkResponse(
            child: Text("${pets[index]['pet_name']}"),
            onTap: () {pushPetView(context, index);},
          )
        );
      }
    );
  } 
}

void pushPetView(BuildContext context, index) {
  Navigator.of(context).pushNamed(PetView.routeName, arguments: index);
}