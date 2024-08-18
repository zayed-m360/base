part of 'timer_bloc.dart';

@immutable
sealed class TimerState {}

final class TimerInitialState extends TimerState {}

final class TimerRefreshState extends TimerState {
  final int minutes;
  final int seconds;

  TimerRefreshState(this.minutes, this.seconds);
}

final class TimerCompleteState extends TimerState {}