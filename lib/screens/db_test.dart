import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DbTest extends StatelessWidget {
  const DbTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('posts')
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var post = snapshot.data!.docs[index];
              return ListTile(
                leading: Text(post['name']),
                title: Text(post['breed'])
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