part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthActionState extends AuthState {}

final class PreviousLoginInitial extends AuthState {}

final class NoPreviousDataState extends AuthState {}

final class LoginSuccessState extends AuthActionState {}
final class AuthLoadingState extends AuthActionState {}
final class ErrorState extends AuthActionState {
  final String errorMessage;

  ErrorState({required this.errorMessage });
}