part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {}

final class TimerStartEvent extends TimerEvent {
  final int totalSeconds;

  TimerStartEvent(this.totalSeconds);
}
