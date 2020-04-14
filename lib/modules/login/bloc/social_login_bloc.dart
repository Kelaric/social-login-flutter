import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_fb_fire_login/services/fb_login.dart';
import 'package:google_fb_fire_login/services/google_login.dart';

part 'social_login_event.dart';
part 'social_login_state.dart';

class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  @override
  SocialLoginState get initialState => SocialLoginInitial();

  @override
  Stream<SocialLoginState> mapEventToState(
    SocialLoginEvent event,
  ) async* {
    if (event is SubmitEvent) {
      if (event.isGoogleLogin) {
        yield LoadingState();
        var user = await signInWithGoogle();
        if (user.email.isNotEmpty) {
          print('calling success state');

          yield SuccessState();
        }
      } else {
        yield LoadingState();
        var user = await fbLogin();
        if (user.email.isNotEmpty) {
           print('calling success state');
          yield SuccessState();
        }
      }
    }
  }
}
