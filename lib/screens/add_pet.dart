import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddPetTabBodyWidget extends StatefulWidget {
  const AddPetTabBodyWidget({Key? key}) : super(key: key);

  @override
  State<AddPetTabBodyWidget> createState() => _AddPetTabBodyWidgetState();
}

class _AddPetTabBodyWidgetState extends State<AddPetTabBodyWidget> {
  
  final formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();

  String? name;
  String? type = 'Other';
  String? breed = 'Other';
  List<String> dispositions = [];
  String? availability = 'Not Available';
  String? newsItem;
  String? description;

  String dropdownValue = 'Dog';
  String dropdownValue1 = 'Other';
  String dropdownValue2 = 'Available';
  bool isGoodWithKids = false;
  bool isGoodWithOtherAnimals = false;
  bool mustBeLeashed = false;
  bool seperationAnxiety = false;
  bool isProtective = false;
  bool isEnergetic = false;
  bool isAffectionate = false;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(10),
      child: 
      Form(
        key: formKey,
        child: Column(
          children: [
      
            petNameField(),
            petTypeField(),
            petBreedField(),
            petAvailabilityField(),
            petDescriptionField(),
            petDispositionField2(),
            //petNewsItemField(),
      
            // RaisedButton(
            //   onPressed: () {},
            //   child: Text('Choose Photo and Save Entry')
            // )
            selectImageButton()
          ]),
      )
      )
    );
  }

    Future getImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      image = File(pickedFile!.path);
      var fileName = '${DateTime.now()}.jpg';
      Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(image!);
      await uploadTask;
      final url = await storageReference.getDownloadURL();
      return url;
    }

   void uploadData() async {
    final url = await getImage();
    FirebaseFirestore.instance
      .collection('pets')
      .add({
        'name': name,
        'type': type,
        'breed': breed,
        'dispositions': dispositions,
        'availability': availability,
        'description': description,
        'userId': "userID1234567",
        'imgUrl': url,
        'liked': 0,
        'dateCreated': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        //'newsItem': newsItem
      });
  }

  Widget selectImageButton() {
    return ElevatedButton(
      child: const Text("Choose photo and upload data"),
      onPressed: () async {
        if(formKey.currentState!.validate()){
          dispositions.clear();
          if (isGoodWithKids == true){dispositions.add('Good with Kids');}
          if (isGoodWithOtherAnimals == true){dispositions.add('Good With Other Animals');}
          if (mustBeLeashed == true){dispositions.add('Must Be Leashed At All Times');}
          if (seperationAnxiety == true){dispositions.add('Seperation Anxiety');}
          if (isProtective == true){dispositions.add('Protective');}
          if (isEnergetic == true){dispositions.add('Energetic');}
          if (isAffectionate == true){dispositions.add('Affectionate');}
          formKey.currentState!.save();
          uploadData();
        }
      },
    );
  }



  Widget petNameField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Pet Name'
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Name cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          name = value;
        }
      )
    );
  }

  Widget petTypeText(){
    return const Padding(padding: EdgeInsets.all(5),
    child: Text("Type:           "),
    );
  }

  Widget petBreedText(){
    return const Padding(padding: EdgeInsets.all(5),
    child: Text("Breed:         "),
    );
  }

  Widget petAvailabilityText(){
    return const Padding(padding: EdgeInsets.all(5),
    child: Text("Availability: "),
    );
  }

  Widget petTypeField(){
    return Row(children: [petTypeText(), 
    Padding(
      padding: const EdgeInsets.all(5),
      child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          type = newValue;
        });
      },
      items: <String>['Other', 'Dog', 'Cat', 'Bird', 'Rabbit']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      )
    ),]
    );
  }



    Widget petBreedField(){
    return Row(children: [petBreedText(),
    Padding(
      padding: const EdgeInsets.all(5),
      child: DropdownButton<String>(
      value: dropdownValue1,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue1 = newValue!;
          breed = newValue;
        });
      },
      items: <String>['Other', 'American Shorthair', 'Beagle', 'Bengal', 'Boxer', 'Californian', 'Chihuahua',
      'Cockatiel', 'Dachshund', 'Domestic Longhair', 'Domestic Shorthair', 'Dove', 'Dutch',
      'Dwarf Papillon', 'Flemish Giant', 'Finch', 'French Lop', 'Holland Lop', 'Husky', 'Lion Head', 
      'Lovebird', 'Maine Coon', 'Netherland Dwarf', 'Mini Lop', 'Mini Rex', 'Parakeet', 'Poodle',
      'Ragdoll', 'Retriever', 'Rottweiler', 'Russian Blue', 'Shepard', 'Shar-pei', 'Siamese', 'Terrier'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
    ),]
    );
  }

  Widget petDispositionField2(){
    return Padding(
      padding: const EdgeInsets.all(5), 
      child: Column(
        children: [

          CheckboxListTile(
            title: Text("Good With Kids", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: isGoodWithKids,
            onChanged: (bool? value){
              setState(() {
                isGoodWithKids = value!;
                print(isGoodWithKids);
              });
            },
          ),

          CheckboxListTile(
            title: Text("Good With Other Animals", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: isGoodWithOtherAnimals,
            onChanged: (bool? value){
              setState(() {
                isGoodWithOtherAnimals = value!;
                print(isGoodWithOtherAnimals);
              });
            },
          ),

          CheckboxListTile(
            title: Text("Must Be Leashed At All Times", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: mustBeLeashed,
            onChanged: (bool? value){
              setState(() {
                mustBeLeashed = value!;
                print(mustBeLeashed);
              });
            },
          ),

          CheckboxListTile(
            title: Text("Sepration Anxiety", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: seperationAnxiety,
            onChanged: (bool? value){
              setState(() {
                seperationAnxiety = value!;
                print(seperationAnxiety);
              });
            },
          ),

          CheckboxListTile(
            title: Text("Is Protective", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: isProtective,
            onChanged: (bool? value){
              setState(() {
                isProtective = value!;
                print(isProtective);
              });
            },
          ),

          CheckboxListTile(
            title: Text("Is Affectionate", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: isAffectionate,
            onChanged: (bool? value){
              setState(() {
                isAffectionate = value!;
                print(isAffectionate);
              });
            },
          ),

          CheckboxListTile(
            title: Text("Is Energetic", style: TextStyle(fontSize: 12, fontFamily: 'Inter',)),
            controlAffinity: ListTileControlAffinity.leading,
            value: isEnergetic,
            onChanged: (bool? value){
              setState(() {
                isEnergetic = value!;
                print(isEnergetic);
              });
            },
          ),
        ],
      )
    );
  }

  Widget petAvailabilityField(){
    return Row(children: [petAvailabilityText(), Padding(
      padding: const EdgeInsets.all(5),
      child: DropdownButton<String>(
      value: dropdownValue2,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue2 = newValue!;
          availability = newValue;
        });
      },
      items: <String>['Available', 'Not Available', 'Pending', 'Adopted'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
    )]
    );
  }

  Widget petDescriptionField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'Pet Description',
          contentPadding: EdgeInsets.symmetric(vertical: 20.0)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet Description cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          description = value;
        }
      )
    );
  }

    Widget petNewsItemField(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'Pet NewsItem',
          contentPadding: EdgeInsets.symmetric(vertical: 20.0)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Pet NewsItem cannot be empty';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          newsItem = value;
        }
      )
    );
  }
}