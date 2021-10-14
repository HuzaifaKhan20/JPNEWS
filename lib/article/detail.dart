import 'package:flutter/gestures.dart';
import 'package:jpnews/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            article.title,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue[400],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (article.urlToImage == null)
                            ? AssetImage('images/back1.jpg')
                            : NetworkImage(article.urlToImage),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    article.source.name != null
                        ? article.source.name
                        : 'No source',
                    style: TextStyle(
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  article.title != null ? article.title : 'Breaking News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                  ),
                ),
                Text(
                  article.description != null
                      ? article.description
                      : 'There is no description for this news',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' ',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: " ", style: TextStyle(color: Colors.black)),
                  TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "Jawan Pakistan News",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          var url = article.url != null
                              ? article.url
                              : 'Breaking News';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                ])),
                SizedBox(
                  height: 10,
                ),
                Text("Author:"),
                Text(
                  article.author != null ? article.author : 'Unknown',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
