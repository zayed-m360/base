import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ota_b2c/models/otp/reset_password_model.dart';
import 'package:ota_b2c/models/otp/send_otp_model.dart';

import '../../configs/app_urls.dart';
import '../../models/otp/otp_match_model.dart';
import '../../repositories/repositories.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  String? email, otp, token, password; 
  SendOtpModel? otpModel;
  VerifyOtpModel? varifyOtpModel;
  ResetPasswordModel? resetPasswordModel;
  bool fromResend = false;
  OtpBloc() : super(OtpInitial()) {
    on<SendOtpEvent>(sendOtpEvent);
    on<VerifyOtpEvent>(verifyOtpEvent);
    on<ResetPasswordEvent>(newPasswordEvent);
  }

  FutureOr<void> sendOtpEvent(SendOtpEvent event, Emitter<OtpState> emit) async {
    if (!fromResend)emit(OTPLoadingState());
    
    email = event.email;
    Map<String, String> payload = {
      "email": event.email,
      "type":"reset_user",
    };
    final sendOTPResponse = await postResponse(url: AppUrls.sendOTP, payload: payload);
    otpModel = sendOtpModelFromJson(sendOTPResponse);

    if(otpModel?.success == true && !fromResend) {
      //if it was from resend, then it doesnt need to change the ui
      emit(SendOTPSuccessState());
      emit(ShowOTPFormState());
    }else if (!fromResend){
      emit(SendOTPFailedState(errorMessage: otpModel?.message??""));
    }
  }

  FutureOr<void> verifyOtpEvent(VerifyOtpEvent event, Emitter<OtpState> emit) async{
    emit(OTPLoadingState());
    otp = event.otp;
    Map<String, String> payload = {
      "email": email??"",
      "otp" : event.otp,
      "type":"reset_user",
    };
    final verifyOTPResponse = await postResponse(url: AppUrls.verifyOTP, payload: payload);
    varifyOtpModel = verifyOtpModelFromJson(verifyOTPResponse);

    if(varifyOtpModel?.success == true) {
      token = varifyOtpModel?.token??"";
      emit(VerifyOTPSuccessState());
      emit(ShowPasswordFormState());
    }else{
      emit(VerifyOTPFailedState(errorMessage: varifyOtpModel?.message??""));
    }
  }

  FutureOr<void> newPasswordEvent(ResetPasswordEvent event, Emitter<OtpState> emit) async{
    emit(OTPLoadingState());
    password = event.newPassword;
    Map<String, String> payload = {
      "token": token??"",
      "password" : event.newPassword,
    };
    final resetPasswordResponse = await postResponse(url: AppUrls.resetPassword, payload: payload);
    resetPasswordModel = resetPasswordModelFromJson(resetPasswordResponse);

    if(otpModel?.success == true) {
      emit(PasswordResetSuccessState());
    }else{
      emit(PasswordResetFailedState(errorMessage: otpModel?.message??""));
    }
  }
}
