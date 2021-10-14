import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jpnews/bottombar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jpnews/screens/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  bool _isHidden = true;
  bool loggedIn = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final String email = emailController.text;
      final String password = passwordController.text;
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        await storage.write(key: "uid", value: user.user.uid);
        final DocumentSnapshot snapshot =
            await db.collection("user").doc(user.user.uid).get();
        snapshot.data();
        this.setState(() {
          loggedIn = true;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Bottombar()));
        print("user is logged in");
      } catch (e) {
        print("error");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(e.toString()),
              );
            });
      }
    }

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/back3.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: Image.asset(
                'images/logo.png',
                width: 100,
                height: 110,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Jawan Pakistan News',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.lightBlue[400],
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(0)),
                  fillColor: Color.fromRGBO(255, 255, 255, 0.6),
                  filled: true,
                  hoverColor: Colors.grey[900],
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.go,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.lightBlue[400],
                controller: passwordController,
                obscureText: _isHidden,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outlined,
                    color: Colors.white,
                  ),
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHidden ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: (Colors.black))),
                  hoverColor: Colors.grey[900],
                  fillColor: Color.fromRGBO(255, 255, 255, 0.6),
                  filled: true,
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Colors.lightBlue[400],
                  ),
                  onPressed: login,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  )),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Text(
                      "Want to create new account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              primary: Colors.grey[700],
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (Signup())));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16),
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
