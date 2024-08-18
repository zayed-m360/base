import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitialState()) {
    on<TimerStartEvent>(_onStartTimer);
  }

  void _onStartTimer(TimerStartEvent event, Emitter<TimerState> emit) async {
    int totalSeconds = event.totalSeconds;

    while (totalSeconds >= 0) {
      int minutes = totalSeconds ~/ 60;
      int seconds = totalSeconds % 60;

      emit(TimerRefreshState(minutes, seconds));

      await Future.delayed(const Duration(seconds: 1));
      totalSeconds--;
    }
    emit(TimerCompleteState());
  }
}
