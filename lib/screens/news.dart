import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adoption_hero/main.dart';
import 'news_article.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  static const routeName = 'news';

  @override
  Widget build(BuildContext context) {

    List<String> entries = <String>['A', 'B', 'C'];
    List<int> colorCodes = <int>[600, 500, 100];
    
    final items = List<Map>.generate(40, (i) {
      return {
        'title': 'News Title $i', 
        'subtitle': 'Subtitle for News Item $i'
      };
    });

    return ListView.builder(itemCount: items.length, itemBuilder: (context, index) {
        print('Creating item $index');
        return ListTile(
          leading: FlutterLogo(),
          trailing: Icon(Icons.more_horiz),
          title: Text("${items[index]['title']}"),
          subtitle: Text("${items[index]['subtitle']}"),
          onTap: () => pushNews(context),
        );
    });

  }
}

void pushNews(BuildContext context) {
  Navigator.of(context).pushNamed(NewsArticle.routeName);
}