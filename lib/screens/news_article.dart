import 'package:flutter/material.dart';
import 'news.dart';

class NewsArticle extends StatelessWidget {

  static const routeName = 'news_article';

  @override
  Widget build(BuildContext context) {

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
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[

                Padding(
                padding: EdgeInsets.all(10), 
                child: Container(
                  height: 350, width: double.infinity, 
                  child: Image.asset('assets/images/some_news.jpg'))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("Article Title"))
                ),

                Padding(
                  padding: EdgeInsets.all(10), 
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                    ),
                    width: double.infinity, 
                    child: Text("Article Words"))
                ),

                ],
            ),)), 
      
    );
  
    // return Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       textPlaceHolder(context),
    //       backToNewsButton(context),
    //     ],
    //   )
    // );

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