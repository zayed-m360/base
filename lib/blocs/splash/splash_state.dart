part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class ShowLoginFormState extends SplashState{}
final class ShowSignupFormState extends SplashState{}
final class ShowSentOTPFormState extends SplashState{}