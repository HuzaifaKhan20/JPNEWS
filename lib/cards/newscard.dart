import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jpnews/checkuser/check.dart';
import 'package:jpnews/model/article_model.dart';
import 'package:jpnews/article/detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget newscard(Article article, BuildContext context) {
  Future addTofav() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("favorites");
    return _collectionRef.doc(currentUser.email).collection("items").doc().set({
      "title": article.title,
      "images": article.urlToImage,
      "author": article.author,
    }).then(
        (value) => Fluttertoast.showToast(msg: "Article Added In favorite"));
  }

  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(
                    article: article,
                  )));
    },
    child: Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: (article.urlToImage == null)
                      ? AssetImage('images/back1.jpg')
                      : NetworkImage(article.urlToImage),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.lightBlue[400],
                        borderRadius: new BorderRadius.circular(0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        article.source.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            article.title != null ? article.title : 'Breaking News',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(children: [
            Container(height: 60, width: 50, child: check(article, context)),
            SizedBox(
              width: 120,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Row(children: [
                  Icon(
                    Icons.timer_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Few Hours Ago',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black),
                  ),
                ])),
          ]),
          Divider(
            thickness: 3,
          )
        ],
      ),
    ),
  );
}
