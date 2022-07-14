import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';

class ProfileTabBodyWidget extends StatelessWidget {
  const ProfileTabBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.all(8.0),
      color: Colors.green[50],
      alignment: Alignment.center,
      child: Text('Profile Page?',
                style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black)
              ),
    );
  } 
}