import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fb_fire_login/home.dart';
import 'package:google_fb_fire_login/modules/login/bloc/social_login_bloc.dart';
import 'package:google_fb_fire_login/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  onGoogleLogin() async {
    BlocProvider.of<SocialLoginBloc>(context)
        .add(SubmitEvent(isGoogleLogin: true));
  }

  onFacebookLogin() async {
    BlocProvider.of<SocialLoginBloc>(context)
        .add(SubmitEvent(isGoogleLogin: false));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      home: Scaffold(
        body: BlocBuilder<SocialLoginBloc, SocialLoginState>(
            bloc: SocialLoginBloc(),
            builder: (context, state) {
              if (state is SocialLoginInitial) {
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
                          onGoogleLogin();

                          // var user = await AuthService.signInWithGoogle(context);
                          // if (user.email.isNotEmpty) {
                          //   Navigator.pushNamed(context, '/home');
                          // }
                        },
                        child: Text('Sign In with Google'),
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blueAccent,
                        onPressed: () async {
                          onFacebookLogin();

                          // var user = await FbLoginService.fbLogin();
                          // if (user.email.isNotEmpty) {
                          //   Navigator.pushNamed(context, '/home');
                          // }
                        },
                        child: Text('Sign In with Facebook '),
                      )
                    ],
                  ),
                );
              } else if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                );
              } else {
                return Spacer();
              }
            }),
      ),
    );
  }
}
