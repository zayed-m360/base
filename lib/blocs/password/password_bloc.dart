import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  bool passwordVisible = false;
  PasswordBloc() : super(PasswordInitial()) {
    on<TogglePasswordEvent>(togglePasswordEvent);
  }

  FutureOr<void> togglePasswordEvent(TogglePasswordEvent event, Emitter<PasswordState> emit) {
    passwordVisible =!passwordVisible;
    emit(TogglePasswordState());
  }
}
