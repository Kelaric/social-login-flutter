// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fb_fire_login/drawer.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   Firestore firestore = Firestore();
//   String name = '';
//   String email = '';
//   String profileUrl = '';
//   // Map<String,dynamic> userDetails;
//   @override
//   void initState() {
//     getUserDetails();
//     super.initState();
//   }

//   getUserDetails() async {
//     var currentUser = await firebaseAuth.currentUser();
//     String uuid = currentUser.uid;

//     var userData = await firestore.collection('users').document(uuid).get();
//     print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//     print(userData.data);
//     setState(() {
//       name = userData.data['name'] ?? '';
//       email = userData.data['email'] ?? '';
//       profileUrl = userData.data['profile_url'] ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         drawer: DrawerPage(profileUrl, email, name),
//         appBar: AppBar(
//           actions: <Widget>[
//             InkWell(
//               onTap: () {
//                 Navigator.pushNamed(context, '/users_list');
//               },
//               child: Container(
//                 margin: EdgeInsets.only(
//                   right: 20.0,
//                 ),
//                 child: CircleAvatar(
//                   child: Icon(
//                     Icons.person,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           title: Text('HomePage'),
//         ),
//         body: Container(
//           child: Column(
//             children: <Widget>[
//               Text('hello harsh'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
