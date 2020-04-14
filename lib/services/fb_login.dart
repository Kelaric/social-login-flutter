import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

Future<FirebaseUser> fbLogin() async {
  
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  
  Firestore firestoreDb = Firestore.instance;

  FacebookLogin facebookLogin = FacebookLogin();
  

 final result = await facebookLogin.logIn(['email','public_profile','user_birthday']);
 
 FacebookAccessToken accessToken=result.accessToken;

 AuthCredential authCredential= FacebookAuthProvider.getCredential(accessToken:  accessToken.token);

 var userDetails=await firebaseAuth.signInWithCredential(authCredential);

  print(">>>>>>>>>>>>>>>>>>>>>>>>");
  // print(userDetails.additionalUserInfo);
  print(userDetails.user);
  print(userDetails.user.email);
  print(userDetails.additionalUserInfo.profile['picture']['url']);
  print(userDetails.additionalUserInfo.profile['name']);
  // print(userDetails.additionalUserInfo.profile['email_verified']);
  print(userDetails.additionalUserInfo.profile['email']);
  print(userDetails.additionalUserInfo.providerId);
 
   var currentUser=  await firebaseAuth.currentUser();
   String uuid=currentUser.uid;
  
   await firestoreDb.collection('users').document(uuid).setData({
    'profile_url':userDetails.user.photoUrl,
    'email':userDetails.user.email,
    'name': userDetails.user.displayName,
    'is_email_verified': userDetails.user.isEmailVerified,
    'token': accessToken.token,
    'provider': userDetails.user.providerId

  });
  
  return userDetails.user;

}
