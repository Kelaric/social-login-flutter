import 'package:flutter/material.dart';
import 'package:google_fb_fire_login/home.dart';
import 'package:google_fb_fire_login/main.dart';
import 'package:google_fb_fire_login/profile.dart';
import 'package:google_fb_fire_login/users_list.dart';

class Routes{
  static Map<String,WidgetBuilder> getRoute(){
    return  <String, WidgetBuilder>{
          // '/': (_) => MyApp(),
          '/home': (_) => HomePage(),
          '/users_list': (_) => UsersList(),
          '/profile': (_) => ProfilePage(),
         
        };
  }
}