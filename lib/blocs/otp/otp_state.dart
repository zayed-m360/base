part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}
sealed class OtpActionState extends OtpState {}

final class OtpInitial extends OtpState {}

final class ShowOTPFormState extends OtpState {}
final class ShowPasswordFormState extends OtpState {}

final class OTPLoadingState extends OtpActionState {}
final class SendOTPSuccessState extends OtpActionState {}
final class VerifyOTPSuccessState extends OtpActionState {}
final class PasswordResetSuccessState extends OtpActionState {}


final class SendOTPFailedState extends OtpActionState {
  final String errorMessage;

  SendOTPFailedState({required this.errorMessage});
}
final class VerifyOTPFailedState extends OtpActionState {
  final String errorMessage;

  VerifyOTPFailedState({required this.errorMessage});
}
final class PasswordResetFailedState extends OtpActionState {
  final String errorMessage;

  PasswordResetFailedState({required this.errorMessage});
}
