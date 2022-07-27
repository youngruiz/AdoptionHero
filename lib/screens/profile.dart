import 'package:flutter/material.dart';

class ProfileTabBodyWidget extends StatelessWidget {
  const ProfileTabBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.all(8.0),
      color: Colors.green[50],
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[

                Padding(
                padding: EdgeInsets.all(10), 
                child: Container(
                  height: 350, width: double.infinity, 
                  child: Image.asset('assets/images/clown.jpg'))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("USER INFO"))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("USER INFO"))
                ),

                ],
            ),)), 
    );
  } 
}