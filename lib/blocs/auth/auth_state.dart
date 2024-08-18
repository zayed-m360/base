part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthActionState extends AuthState {}

final class PreviousLoginInitial extends AuthState {}

final class NoPreviousDataState extends AuthState {}

final class LoginSuccessState extends AuthActionState {}
final class AuthLoadingState extends AuthActionState {}
final class AuthErrorState extends AuthActionState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage });
}
final class PreviousAuthErrorState extends AuthActionState {
  final String errorMessage;

  PreviousAuthErrorState({required this.errorMessage });
}