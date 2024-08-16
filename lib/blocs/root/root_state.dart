part of 'root_bloc.dart';

sealed class RootState {}

abstract class RootActionState extends RootState {}

final class RootInitial extends RootState {}

class NavigateToVisaState extends RootState {}

class NavigateToTicketState extends RootState {}

class NavigateToFlightState extends RootState {}

class NavigateToBookedFlightState extends RootState {}

class ToggleMoreOptionsState extends RootActionState {}