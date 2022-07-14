import 'package:flutter/material.dart';
import 'package:adoption_hero/main.dart';

class NewsTabBodyWidget extends StatelessWidget {
  const NewsTabBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> entries = <String>['A', 'B', 'C'];
    List<int> colorCodes = <int>[600, 500, 100];
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('News Item ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}