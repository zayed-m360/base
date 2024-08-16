import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ota_b2c/configs/colors.dart';
import 'package:ota_b2c/views/more/more_options.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../blocs/root/root_bloc.dart';
import 'booked_flight/booked_flight_screen.dart';
import 'flight/flight_screen.dart';
import 'ticket/ticket_screen.dart';
import 'visa/visa_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  final List screens = const [
    VisaScreen(),
    TicketScreen(),
    FlightScreen(),
    BookedFlightScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    context.read<RootBloc>().add(RootInitialEvent());
    return BlocConsumer<RootBloc, RootState>(
      listenWhen: (previous, current) => current is RootActionState,
      buildWhen: (previous, current) => current is! RootActionState,
      listener: (BuildContext context, RootState state) {
        if (state is ToggleMoreOptionsState && state.isVisible) {
          showDialog(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) {
              return const Stack(
                children: [
                  Positioned(
                    bottom: 60,
                    right: 0,
                    child: SizedBox(
                      width: 100,
                      child: Dialog(
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.zero,
                        child: MoreOptions(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
        builder: (context, state) {
        Widget body;

        if (state is NavigateToVisaState) {
          body = screens[0];
        } else if (state is NavigateToTicketState) {
          body = screens[1];
        } else if (state is NavigateToFlightState) {
          body = screens[2];
        } else if (state is NavigateToBookedFlightState) {
          body = screens[3];
        } else {
          body = Container();
        }

        return Scaffold(
          body: Stack(
            children: [
              body,
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildNavItem(
                    context,
                    state is NavigateToVisaState,
                    icon: HugeIcons.strokeRoundedDocumentAttachment,
                    label: "Visa",
                    onTap: () {
                      context.read<RootBloc>().add(NavigateToVisaEvent());
                    },
                  ),
                  buildNavItem(
                    context,
                    state is NavigateToTicketState,
                    icon: HugeIcons.strokeRoundedTicket01,
                    label: "Ticket",
                    onTap: () {
                      context.read<RootBloc>().add(NavigateToTicketEvent());
                    },
                  ),
                  buildNavItem(
                    context,
                    state is NavigateToFlightState,
                    icon: HugeIcons.strokeRoundedAirplaneTakeOff01,
                    label: "Flight",
                    onTap: () {
                      context.read<RootBloc>().add(NavigateToFlightEvent());
                    },
                  ),
                  buildNavItem(
                    context,
                    state is NavigateToBookedFlightState,
                    icon: HugeIcons.strokeRoundedCalendar02,
                    label: "Booked",
                    onTap: () {
                      context.read<RootBloc>().add(NavigateToBookedFlightEvent());
                    },
                  ),
                  buildNavItem(
                    context,
                    state is ToggleMoreOptionsState && state.isVisible,
                    icon: HugeIcons.strokeRoundedMore01,
                    label: "More",
                    onTap: () {
                      context.read<RootBloc>().add(ToggleMoreOptionsEvent());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNavItem(BuildContext context, bool isActive,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(
            icon: icon,
            size: isActive ? 25 : 20,
            color: isActive ? Colors.white : Colors.white70,
          ),
          Text(
            label,
            style: myText(
              color: isActive ? AppColors.textColorw1 : AppColors.textColorw3,
            ),
          ),
        ],
      ),
    );
  }
}
