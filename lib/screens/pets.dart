import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';
import 'pet_view.dart';

class Pets extends StatelessWidget {
  const Pets({Key? key}) : super(key: key);
  
  static const routeName = 'pets';

  @override
  Widget build(BuildContext context) {

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
              var petData = new Map();
              petData['name'] = post['name'];
              petData['availability'] = post['availability'];
              petData['breed'] = post['breed'];
              petData['type'] = post['type'];
              petData['description'] = post['description'];
              petData['imgUrl'] = post['imgUrl'];

              
              return Card(
                color: Colors.teal[100],
                child: InkResponse(
                  child: Stack(children: <Widget>[
                      Image.network(petData['imgUrl']),
                      Container(
                        alignment: Alignment.bottomLeft, 
                        child: Padding(
                          padding: EdgeInsets.all(10), 
                          child: Text(petData['name'], style: TextStyle(color: Colors.white,fontSize: 24, fontFamily: 'Inter-Bold')))),
                    ],),
                  
                  
                  onTap: () {pushPetView(context, petData);},
                ),  
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

void pushPetView(BuildContext context, petData) {
  Navigator.of(context).pushNamed(PetView.routeName, arguments: petData);
}