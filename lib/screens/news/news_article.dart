import 'package:flutter/material.dart';
import 'news.dart';

class NewsArticle extends StatelessWidget {

  static const routeName = 'news_article';

  @override
  Widget build(BuildContext context) {

    Map newsData = ModalRoute.of(context)?.settings.arguments as Map;
    String newsTitle = newsData['title'];
    String newsArticleBody = newsData['articleBody'];
    String newsImgUrl = newsData['imgUrl'];
    String newsAuthor = newsData['author'];

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Icon(Icons.pets_rounded),
        backgroundColor: Colors.green[100],
        leading: BackButton(
            color: Colors.black,
            onPressed: () => {backToNews(context)},
        ),
      ),
      body: 
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[

                Padding(
                padding: const EdgeInsets.all(10), 
                child: SizedBox(
                  height: 350, width: double.infinity, 
                  child: Image.network(newsImgUrl))
                ),

                Padding(
                  padding: const EdgeInsets.all(10), 
                  child: SizedBox(
                    width: double.infinity, 
                    child: Text(newsTitle, style: const TextStyle(fontSize: 36, fontFamily: 'Inter-Bold')))
                ),


                const Padding(padding: EdgeInsets.only(left: 10, right: 10), child: Divider(color: Colors.black)),

                Padding(
                  padding: const EdgeInsets.all(10), 
                  child: SizedBox(
                    width: double.infinity, 
                    child: Text("By $newsAuthor", style: const TextStyle(fontSize: 18, fontFamily: 'Tinos')))
                ),

                const Padding(padding: EdgeInsets.only(left: 10, right: 10), child: Divider(color: Colors.black)),

                Padding(
                  padding: const EdgeInsets.all(10), 
                  child: SizedBox(
                    width: double.infinity, 
                    child: Text(newsArticleBody, style: const TextStyle(fontSize: 22, fontFamily: 'Tinos')))
                ),

                ],
            ),)), 
      
    );
  
  }

}

void backToNews(BuildContext context){
  Navigator.of(context).pop();
}

Widget textPlaceHolder(BuildContext context) {
  return Text('This News Article', style: Theme.of(context).textTheme.displayLarge);
}

Widget backToNewsButton(BuildContext context) {
  return RaisedButton(
    child: Text('Back to News', style: Theme.of(context).textTheme.displaySmall),
    onPressed: () => backToNews(context)
  );
}