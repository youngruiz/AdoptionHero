import 'package:cloud_firestore/cloud_firestore.dart';
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

    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('pets')
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
          return GridView.builder(
            padding: EdgeInsets.only(top: 5),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0
                    ),
            itemCount: snapshot.data!.docs.length, 
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              return Card(
                color: Colors.teal[100],
                child: Column(
                  children: [
                    InkResponse(
                      child: Text(post['name']),
                      onTap: () {pushPetView(context, index);},
                    ),
                    InkResponse(
                      child: Text(post['type'])
                    ),
                    InkResponse(
                      child: Text(post['breed'])
                    ),
                    InkResponse(
                      child: Text(post['disposition'])
                    ),
                    InkResponse(
                      child: Text(post['availability'])
                    ),
                    InkResponse(
                      child: Text(post['description'])
                    ),
                  ],
                )
              );
            }
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
      );
  } 
}

void pushPetView(BuildContext context, index) {
  Navigator.of(context).pushNamed(PetView.routeName, arguments: index);
}