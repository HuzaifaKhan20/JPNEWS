import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpnews/screens/home.dart';
import 'package:jpnews/screens/search.dart';
import 'package:jpnews/checkuser/userprofile.dart';
import 'package:jpnews/checkuser/userfavorite.dart';
import 'package:bottom_bars/bottom_bars.dart';

class Bottombar extends StatefulWidget {
  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BottomBars(
        backgroundBarColor: Colors.lightBlue[400],
        items: [
          BottomBarsItem(
            page: Scaffold(
              body: Home(),
            ),
            item: Item(
              activeColor: Colors.grey[900],
              color: Colors.white,
              icon: Icons.home_outlined,
              iconSize: 30,
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          BottomBarsItem(
            page: Scaffold(
              body: Search(),
            ),
            item: Item(
              activeColor: Colors.grey[900],
              color: Colors.white,
              icon: Icons.search_outlined,
              iconSize: 30,
              title: Text(
                "Search",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          BottomBarsItem(
            page: Scaffold(
              body: userfavorite(),
            ),
            item: Item(
              activeColor: Colors.grey[900],
              color: Colors.white,
              icon: Icons.favorite_outline,
              iconSize: 30,
              title: Text(
                "Favorite",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          BottomBarsItem(
            page: Scaffold(
              body: userprofile(),
            ),
            item: Item(
              activeColor: Colors.grey[900],
              icon: Icons.person_outline,
              iconSize: 30,
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
