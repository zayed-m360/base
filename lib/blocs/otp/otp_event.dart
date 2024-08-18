part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class SendOtpEvent extends OtpEvent {
  final String email;

  SendOtpEvent({required this.email});
}
class VerifyOtpEvent extends OtpEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});
}
class ResetPasswordEvent extends OtpEvent {
  final String newPassword;
  ResetPasswordEvent({required this.newPassword});
}