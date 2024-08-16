import 'dart:async';
import 'package:bloc/bloc.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {

  RootBloc() : super(RootInitial()) {
    on<RootInitialEvent>(rootInitialEvent);
    on<NavigateToVisaEvent>(navigateToVisaEvent);
    on<NavigateToTicketEvent>(navigateToTicketEvent);
    on<NavigateToFlightEvent>(navigateToFlightEvent);
    on<NavigateToBookedFlightEvent>(navigateToBookedFlightEvent);
    on<ToggleMoreOptionsEvent>(toggleMoreOptionsEvent);
  }

  FutureOr<void> rootInitialEvent(RootInitialEvent event, Emitter<RootState> emit) {
    emit(NavigateToFlightState());
  }

  FutureOr<void> navigateToVisaEvent(NavigateToVisaEvent event, Emitter<RootState> emit) {
    emit(NavigateToVisaState());
  }

  FutureOr<void> navigateToTicketEvent(NavigateToTicketEvent event, Emitter<RootState> emit) {
    emit(NavigateToTicketState());
  }

  FutureOr<void> navigateToFlightEvent(NavigateToFlightEvent event, Emitter<RootState> emit) {
    emit(NavigateToFlightState());
  }

  FutureOr<void> navigateToBookedFlightEvent(NavigateToBookedFlightEvent event, Emitter<RootState> emit) {
    emit(NavigateToBookedFlightState());
  }

  FutureOr<void> toggleMoreOptionsEvent(ToggleMoreOptionsEvent event, Emitter<RootState> emit) {
    emit(ToggleMoreOptionsState());
  }
}
