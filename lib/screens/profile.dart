import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:jpnews/bottombar.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstname = " loading....";
  String lastname = " loading....";
  String email = "loading....";
  String phone = "loading...";
  String imagePath;
  String downloadUrl;
  String imageurl = "wait";

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image.path;
    });
    print(image.path);
  }

  void submit() async {
    pickImage();
    try {
      String imageName = path.basename(imagePath);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/$imageName');

      File file = File(imagePath);
      await ref.putFile(file);
      downloadUrl = await ref.getDownloadURL();
      FirebaseFirestore db = FirebaseFirestore.instance;
      User user = FirebaseAuth.instance.currentUser;
      await db.collection("users").doc(user.uid).update({
        "url": downloadUrl,
      });
      print("upload successfully");
    } catch (e) {
      print(e);
    }
  }

  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Bottombar()));
      print("object");
    } catch (e) {
      print(e.message);
    }
  }

  void getData() async {
    User user = await FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    setState(() {
      firstname = data.data()['first_name'];
      lastname = data.data()['last_name'];
      email = data.data()['email'];
      phone = data.data()['phone_number'];
      imageurl = data.data()['url'];
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                    width: 500,
                    height: 200.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0)),
                        image: DecorationImage(
                            image: AssetImage("images/back1.jpg"),
                            fit: BoxFit.fill)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          submit();
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.black,
                          child: imageurl == null
                              ? Container()
                              : Container(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        image: imageurl == null ||
                                                imageurl.isEmpty
                                            ? AssetImage('images/wwwlogo.png')
                                            : NetworkImage(imageurl),
                                        fit: BoxFit.cover,
                                      )),
                                  width: 100,
                                  height: 100,
                                ),
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        minLeadingWidth: 0,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: Icon(Icons.person),
                        title: Text(
                          "First_Name:",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        firstname,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        minLeadingWidth: 0,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: Icon(Icons.person),
                        title: Text(
                          "Last_Name:",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        lastname,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        minLeadingWidth: 0,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: Icon(Icons.email),
                        title: Text(
                          "Email Address:",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        email,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        minLeadingWidth: 0,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: Icon(Icons.email),
                        title: Text(
                          "Phone Number:",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        phone,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),

                    // signout
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          signout();
                        },
                        child: ListTile(
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          leading: Icon(Icons.logout),
                          title: Text(
                            "Sign out",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
