part of 'root_bloc.dart';

sealed class RootEvent {}

class RootInitialEvent extends RootEvent {}

class NavigateToVisaEvent extends RootEvent {}

class NavigateToTicketEvent extends RootEvent {}

class NavigateToFlightEvent extends RootEvent {}

class NavigateToBookedFlightEvent extends RootEvent {}

class ToggleMoreOptionsEvent extends RootEvent {}
