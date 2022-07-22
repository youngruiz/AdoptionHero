import 'package:flutter/material.dart';
import 'pets.dart';

class PetView extends StatelessWidget {

  static const routeName = 'pet_view';

  @override
  Widget build(BuildContext context) {

    final int receivedValue = ModalRoute.of(context)?.settings.arguments as int;
    print(receivedValue);

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        
        title: const Icon(Icons.pets_rounded),
        backgroundColor: Colors.green[100],
        leading: BackButton(
            color: Colors.black,
            onPressed: () => {backToPets(context)},
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[

                const Padding(padding: EdgeInsets.only(right: 15),
                  child:
                    Align(alignment: Alignment.topRight,
                      child:
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red,    
                    )
                  )
                ), 

                Padding(
                padding: EdgeInsets.all(10), 
                child: Container(
                  height: 350, width: double.infinity, 
                  child: Image.asset('assets/images/some_pet.jpg'))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("Pet Name"))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("Pet Description"))
                ),


                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("TYPE:                    $receivedValue"))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("BREED:                  $receivedValue"))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("AVAIL.:                   $receivedValue"))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("DESCRIPTION:      $receivedValue"))
                ),




              ],
            ),)), 
    );

  }

}

void backToPets(BuildContext context){
  Navigator.of(context).pop();
}