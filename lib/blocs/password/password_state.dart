part of 'password_bloc.dart';

@immutable
sealed class PasswordState {}

final class PasswordInitial extends PasswordState {}

final class TogglePasswordState extends PasswordState {}