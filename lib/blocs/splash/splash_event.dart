part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

class ShowLoginFormEvent extends SplashEvent{}
class ShowSignupFormEvent extends SplashEvent{}
class ShowEmailFormEvent extends SplashEvent{}