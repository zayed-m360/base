part of 'password_bloc.dart';

@immutable
sealed class PasswordEvent {}

class TogglePasswordEvent extends PasswordEvent {}