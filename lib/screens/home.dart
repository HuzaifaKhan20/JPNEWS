import 'package:flutter/material.dart';
import 'package:jpnews/categories/topstories.dart';
import 'package:jpnews/categories/technology.dart';
import 'package:jpnews/categories/health.dart';
import 'package:jpnews/categories/sport.dart';
import 'package:jpnews/categories/stock.dart';
import 'package:jpnews/categories/entertainment.dart';
import 'package:jpnews/categories/apple.dart';
import 'package:jpnews/categories/tesla.dart';
import 'package:jpnews/categories/popular.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(95),
            child: AppBar(
              flexibleSpace: Container(
                height: 40,
                child: Image.asset(
                  "images/logo.png",
                  width: 30,
                ),
              ),
              backgroundColor: Colors.lightBlue[400],
              bottom: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(text: "Latest \nNews"),
                  // Tab(text: "Trending"),
                  Tab(text: "Stock News"),
                  Tab(text: "Apple News"),
                  Tab(text: "Tech News"),
                  // Tab(text: "Health"),
                  Tab(text: "Tesla News"),
                  // Tab(text: "Entertainment"),
                  // Tab(text: "Sports"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Topstories(),
              // Popular(),
              Stock(),
              Apple(),
              Technology(),
              // Health(),
              Tesla(),
              // Entertainment(),
              // Sports(),
            ],
          ),
        ),
      ),
    );
  }
}
