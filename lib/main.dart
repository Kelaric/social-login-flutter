import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fb_fire_login/home.dart';
import 'package:google_fb_fire_login/routes.dart';
import 'package:google_fb_fire_login/services/google_login.dart' as AuthService;
import 'package:google_fb_fire_login/services/fb_login.dart' as FbLoginService;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    var currentUser = await firebaseAuth.currentUser();
    //  if(currentUser.toString().isNotEmpty){
    //      Navigator.pushNamed(context, '/home');
    //  }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                top: 60,
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: () async {
                      var user = await AuthService.signInWithGoogle(context);
                      if (user.email.isNotEmpty) {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: Text('Sign In with Google'),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () async {
                      var user = await FbLoginService.fbLogin();
                      if (user.email.isNotEmpty) {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    child: Text('Sign In with Facebook '),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
