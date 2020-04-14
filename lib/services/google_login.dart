import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fb_fire_login/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore firestoreDb = Firestore.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  AuthCredential authCredential = GoogleAuthProvider.getCredential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,
  );

  var userDetails = await firebaseAuth.signInWithCredential(authCredential);
  print(">>>>>>>>>>>>>>>>>>>>>>>>");
  print(userDetails.additionalUserInfo.profile['picture']);
  print(userDetails.additionalUserInfo.profile['name']);
  print(userDetails.additionalUserInfo.profile['email_verified']);
  print(userDetails.additionalUserInfo.profile['email']);
  print(userDetails.additionalUserInfo.providerId);

  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (BuildContext context) => HomePage(),
  //   ),
  // );
  ///store user details in firestore
  await firestoreDb.collection('users').add({
    'profile_url':userDetails.user.photoUrl,
    'email':userDetails.user.email,
    'name': userDetails.user.displayName,
    'is_email_verified': userDetails.user.isEmailVerified,
    'token': googleSignInAuthentication.accessToken,
    'provider': userDetails.user.providerId

  });
  return userDetails.user;
}
