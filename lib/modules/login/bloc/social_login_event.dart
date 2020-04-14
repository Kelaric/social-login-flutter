part of 'social_login_bloc.dart';

abstract class SocialLoginEvent extends Equatable {
  const SocialLoginEvent();
}

class SubmitEvent extends SocialLoginEvent {
  final bool isGoogleLogin;
  SubmitEvent({this.isGoogleLogin});

  @override
  List<Object> get props => null;
}
