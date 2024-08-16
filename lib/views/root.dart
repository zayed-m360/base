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

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final List<Widget> screens = const [
    VisaScreen(),
    TicketScreen(),
    FlightScreen(),
    BookedFlightScreen(),
  ];

  final List<RootEvent> navigationHistory = [RootInitialEvent()];

  @override
  Widget build(BuildContext context) {
    context.read<RootBloc>().add(RootInitialEvent());
    return WillPopScope(
      onWillPop: () async {
        if (navigationHistory.isNotEmpty) {
          navigationHistory.removeLast();
          if (navigationHistory.isNotEmpty) {
            final lastEvent = navigationHistory.last;
            context.read<RootBloc>().add(lastEvent);
            return false;
          } else {
            return await _showExitConfirmationDialog(context);
          }
        } else {
          return await _showExitConfirmationDialog(context);
        }
      },
      child: BlocConsumer<RootBloc, RootState>(
        listenWhen: (previous, current) => current is RootActionState,
        buildWhen: (previous, current) => current is! RootActionState,
        listener: (BuildContext context, RootState state) {
          if (state is ToggleMoreOptionsState) {
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
                        _navigateToScreen(context, NavigateToVisaEvent(), state is NavigateToVisaState);
                      },
                    ),
                    buildNavItem(
                      context,
                      state is NavigateToTicketState,
                      icon: HugeIcons.strokeRoundedTicket01,
                      label: "Ticket",
                      onTap: () {
                        _navigateToScreen(context, NavigateToTicketEvent(), state is NavigateToTicketState);
                      },
                    ),
                    buildNavItem(
                      context,
                      state is NavigateToFlightState,
                      icon: HugeIcons.strokeRoundedAirplaneTakeOff01,
                      label: "Flight",
                      onTap: () {
                        _navigateToScreen(context, NavigateToFlightEvent(), state is NavigateToFlightState);
                      },
                    ),
                    buildNavItem(
                      context,
                      state is NavigateToBookedFlightState,
                      icon: HugeIcons.strokeRoundedCalendar02,
                      label: "Booked",
                      onTap: () {
                        _navigateToScreen(context, NavigateToBookedFlightEvent(), state is NavigateToBookedFlightState);
                      },
                    ),
                    buildNavItem(
                      context,
                      state is ToggleMoreOptionsState,
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
      ),
    );
  }

  void _navigateToScreen(BuildContext context, RootEvent event, bool isActive) {
    if (!isActive) {
      navigationHistory.add(event);
      context.read<RootBloc>().add(event);
    }
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit App"),
            content: const Text("Do you really want to close the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes", style: myText(color: AppColors.red, fontWeight: FontWeight.w500),),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No", style: myText(color: AppColors.primary, fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ) ??
        false;
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
