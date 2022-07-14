import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/pet_entry_DTO.dart';

class UploadButton extends StatelessWidget {
  UploadButton({Key? key}) : super(key: key);

  final petEntryDTO = PetEntryDTO(
    name: 'Name',
    type: 'Type',
    breed: 'Breed',
    disposition: 'Disposition',
    availability: 'Availability',
    description: 'Description',
    userId: 'userId',
    imgUrl: 'imgUrl',
    liked: 1,
    dateCreated: DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
    newsItem: 'newsItem'
  );

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.file_upload_outlined),
      onPressed: () async {
        uploadData();
      }
    );
  }

  void uploadData(){
    FirebaseFirestore.instance
      .collection('posts')
      .add({
        'name': petEntryDTO.name,
        'type': petEntryDTO.type,
        'breed': petEntryDTO.breed,
        'disposition': petEntryDTO.disposition,
        'availability': petEntryDTO.availability,
        'description': petEntryDTO.description,
        'userId': petEntryDTO.userId,
        'imgUrl': petEntryDTO.imgUrl,
        'liked': petEntryDTO.liked,
        'dateCreated': petEntryDTO.dateCreated,
        'newsItem': petEntryDTO.newsItem
      });
  }
}