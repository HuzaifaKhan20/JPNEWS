import 'package:jpnews/api_data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:jpnews/cards/newscard.dart';
import 'package:jpnews/model/article_model.dart';

class Technology extends StatefulWidget {
  @override
  _TechnologyState createState() => _TechnologyState();
}

class _TechnologyState extends State<Technology> {
  TechnologyApi client = TechnologyApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  newscard(articles[index], context),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
