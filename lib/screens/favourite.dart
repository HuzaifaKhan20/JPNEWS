import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String collectionName = "favorites";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
    
            title: Center(child: Text("Favorite News")),
            automaticallyImplyLeading: false,

            backgroundColor: Colors.lightBlue[400],
          
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(collectionName)
              .doc(FirebaseAuth.instance.currentUser.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something is wrong"),
              );
            }

            return ListView.builder(
                itemCount:
                    snapshot.data == null ? 0 : snapshot.data.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data.docs[index];
                  void deleteitem() {
                    FirebaseFirestore.instance
                        .collection(collectionName)
                        .doc(FirebaseAuth.instance.currentUser.email)
                        .collection("items")
                        .doc(_documentSnapshot.id)
                        .delete();
                  }

                  return 
                  
                  InkWell(
    onTap: () {
     
    },
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.lightBlue[400],
         
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              //let's add the height

              image: DecorationImage(
                  image: (_documentSnapshot['images'] == null)
                      ? AssetImage('images/back1.jpg')
                      : NetworkImage(_documentSnapshot['images']),
                  
                  fit: BoxFit.cover),
              
            ),
           
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _documentSnapshot['title'] != null ? _documentSnapshot['title'] : 'Breaking News',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height:10),
            RichText(
          text: TextSpan(
            children: [
              TextSpan(
              
                text: "Jawan Pakistan ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
              TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                 text: "News",
                  recognizer: TapGestureRecognizer()..onTap =  () async{
                    var url = _documentSnapshot['url'] != null ? _documentSnapshot['url'] : 'Breaking News';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                  }
              ),
            ]
        )),
          SizedBox(
            height: 5,
          ),
          Row(children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  
                    icon: Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: () {
                      deleteitem();
                      Fluttertoast.showToast(msg: "Article Removed In favorite");
                    })),
            
          ])
        ],
      ),
    ),
  );
                });
          },
        ),
        
     
        );
  }
}
