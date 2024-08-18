import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ota_b2c/configs/app_urls.dart';
import 'package:ota_b2c/models/login_model.dart';
import 'package:ota_b2c/repositories/post_response.dart';

import '../../configs/app_constants.dart';
import '../../database/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? email, password, token;
  LoginModel? loginModel;
  AuthBloc() : super(PreviousLoginInitial()) {
    on<InitialFetchLoginDataEvent>(initialFetchLoginDataEvent);
    on<LoginEvent>(loginEvent);
    on<LogoutEvent>(logoutEvent);
  }

  FutureOr<void> initialFetchLoginDataEvent(InitialFetchLoginDataEvent event, Emitter<AuthState> emit) async {
    try {
      final myData = await LocalDB.getLoginInfo();
      if (myData == null) {
        emit(NoPreviousDataState());
      } else {
        logger.f("message myData: ${myData.length}");
        email = myData[0];
        password = myData[1];
        token = myData[2];
        Map<String, String> payload = {
          "email": email??"",
          "password": password??""
        };
        final loginResponse = await postResponse(url: AppUrls.login, payload: payload);
        loginModel = loginModelFromJson(loginResponse);
        logger.f("name: ${loginModel?.data?.name}");

        await Future.delayed(const Duration(seconds: 1));

        if(loginModel?.success == true) {
          emit(LoginSuccessState());
        }else{
          emit(PreviousAuthErrorState(errorMessage: "Login failed"));
        }
      }
    } catch (e) {
      logger.e("Error during fetch login data: $e");
      emit(PreviousAuthErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    Map<String, String> payload = {
      "email": event.email,
      "password": event.password
    };
    final loginResponse = await postResponse(url: AppUrls.login, payload: payload);
    loginModel = loginModelFromJson(loginResponse);

    await Future.delayed(const Duration(seconds: 1));

    if(loginModel?.success == true) {
      LocalDB.postLoginInfo(email: event.email, password: event.password, token: loginModel?.token??"");
      emit(LoginSuccessState());
    }else{
      emit(AuthErrorState(errorMessage: "Login failed"));
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) {
    try {
      LocalDB.delLoginInfo();
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutFailedState());
    }
  }
}