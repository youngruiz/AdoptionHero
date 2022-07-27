import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adoption_hero/main.dart';
import 'news_article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  static const routeName = 'news';

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('news')
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty){

          return ListView.builder(
            itemCount: snapshot.data!.docs.length, 
            itemBuilder: (context, index) {

              var post = snapshot.data!.docs[index];
              var newsData = new Map();
              newsData['title'] = post['title'];
              newsData['articleBody'] = post['articleBody'];
              newsData['imgUrl'] = post['imgUrl'];
              newsData['author'] = post['author'];

              return ListTile(
                //leading: FlutterLogo(),
                trailing: Image.network(newsData['imgUrl']),
                title: Text(newsData['title']),
                subtitle: Text(newsData['author']),
                onTap: () => {pushNews(context, newsData)},
              );
            }
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );

    // return ListView.builder(itemCount: items.length, itemBuilder: (context, index) {
    //     print('Creating item $index');
    //     return ListTile(
    //       leading: FlutterLogo(),
    //       trailing: Icon(Icons.more_horiz),
    //       title: Text("${items[index]['title']}"),
    //       subtitle: Text("${items[index]['subtitle']}"),
    //       onTap: () => pushNews(context),
    //     );
    // });

  }
}

void pushNews(BuildContext context, newsData) {
  Navigator.of(context).pushNamed(NewsArticle.routeName, arguments: newsData);
}