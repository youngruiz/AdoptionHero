import 'package:flutter/material.dart';

Widget errorAlertDialog(BuildContext context, alertTitle, alertText){
  return AlertDialog(
    title: Text(alertTitle),
    content: Text(alertText),
    actions: [
      TextButton(
        child: const Text('Okay'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}