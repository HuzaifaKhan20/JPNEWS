import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jpnews/screens/login.dart';
import 'package:jpnews/screens/profile.dart';

Widget userprofile() {
  User user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return Profile();
    //signed out
  } else {
    return Login();
    //signed in
  }
}
