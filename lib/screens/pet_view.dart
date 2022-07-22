import 'package:flutter/material.dart';
import 'pets.dart';

class PetView extends StatelessWidget {

  static const routeName = 'pet_view';

  @override
  Widget build(BuildContext context) {
    

    Map petData = ModalRoute.of(context)?.settings.arguments as Map;
    String petName = petData['name'];
    String petBreed = petData['breed'];
    String petType = petData['type'];
    String petAvail = petData['availability'];
    String petDescription = petData['description'];
    String petImgUrl = petData['imgUrl'];


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
                  child: Image.network(petImgUrl))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blueAccent)
                    // ),
                    width: double.infinity, 
                    child: Text("$petName", style: TextStyle(fontSize: 48, fontFamily: 'Inter-Bold'),))
                ),



                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blueAccent)
                    // ),
                    width: double.infinity, 
                    child: Text("TYPE:               $petType", style: TextStyle(fontSize: 24, fontFamily: 'Tinos')))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blueAccent)
                    // ),
                    width: double.infinity, 
                    child: Text("BREED:            $petBreed", style: TextStyle(fontSize: 24, fontFamily: 'Tinos')))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blueAccent)
                    // ),
                    width: double.infinity, 
                    child: Text("AVAIL.:             $petAvail", style: TextStyle(fontSize: 24, fontFamily: 'Tinos')))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blueAccent)
                    // ),
                    width: double.infinity, 
                    child: Text("DESCRIPTION:", style: TextStyle(fontSize: 24, fontFamily: 'Tinos')))
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                   
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5)
                    ),
                    width: double.infinity, 
                    child: Padding(padding: EdgeInsets.all(10), child: Text("$petDescription", style: TextStyle(fontSize: 20, fontFamily: 'Tinos'))))
                ),




              ],
            ),)), 
    );

  }

}

void backToPets(BuildContext context){
  Navigator.of(context).pop();
}