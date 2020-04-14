import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fb_fire_login/profile.dart';

class DrawerPage extends StatefulWidget {
  final String profileUrl;
  final String email;
  final String name;
  DrawerPage(this.profileUrl, this.email, this.name);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.name),
            accountEmail: Text(widget.email),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                // backgroundColor: Colors.lightBlue,
                child: Image.network(widget.profileUrl),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
          ),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.deepPurple),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.lightBlue,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage(),
                ),
              );
            },
            child: ListTile(
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.deepPurple),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
