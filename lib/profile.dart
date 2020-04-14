import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fb_fire_login/camera_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  String email;
  String profileUrl;
  File profileImage;

  bool isImagePicked = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore firestore = Firestore();

  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');

  List<ImageProvider<dynamic>> images = List(2);

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    var currentUser = await firebaseAuth.currentUser();
    String uuid = currentUser.uid;

    var userData = await firestore.collection('users').document(uuid).get();
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(userData.data);
    setState(
      () {
        _nameController.text = userData.data['name'] ?? '';
        _emailController.text = userData.data['email'] ?? '';
        profileUrl = userData.data['profile_url'] ?? '';
      },
    );
    images[0] = NetworkImage(profileUrl);
  }

  updateUserDetails() async {
    var currentUser = await firebaseAuth.currentUser();
    String uuid = currentUser.uid;

    await firestore.collection('users').document(uuid).updateData({
      'name': _nameController.text,
      'email': _emailController.text,
      'profile_url': profileImage.toString() ?? profileUrl,
    });
  }

  void displayDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Message"),
        content: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: new Text("Profile updated sucessfully")),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: new Text("Close"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    print("Open Gallery");
                    var fileImage = await getImage();

                    print(fileImage);
                    this.setState(() {
                      profileImage = fileImage;
                      images[1] = FileImage(fileImage);
                      isImagePicked = true;
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: new CircleAvatar(
                      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      backgroundImage: isImagePicked
                          ? images[1]
                          : images[0] ?? Image.asset('assets/login.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(controller: _nameController),
                SizedBox(
                  height: 20.0,
                ),
                TextField(controller: _emailController),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () async {
                    await updateUserDetails();
                    print('details updated');
                    displayDialog();
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
