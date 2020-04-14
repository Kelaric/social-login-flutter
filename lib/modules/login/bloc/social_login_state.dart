part of 'social_login_bloc.dart';

abstract class SocialLoginState extends Equatable {
  const SocialLoginState();
}

class SocialLoginInitial extends SocialLoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SocialLoginState {
  @override
  List<Object> get props => null;
}

class SuccessState extends SocialLoginState {
  @override
  List<Object> get props => null;
}
