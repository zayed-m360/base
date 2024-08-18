import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ota_b2c/configs/app_routes.dart';
import 'package:ota_b2c/views/splash/splash_screen.dart';

import '../../blocs/auth/auth_bloc.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 50, // Minimum width
            maxWidth: 50, // Maximum width
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 33, 55).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Option 1",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Option 2",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                BlocListener<AuthBloc, AuthState>(
                  listenWhen: (previous, current) => current is AuthActionState,
                  listener: (context, state) {
                    if(state is LogoutSuccessState){
                      AppRoutes.pop(context);//to pop the options
                      AppRoutes.pushReplacement(context, const SplashScreen());
                    }if(state is LogoutFailedState){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                           content: Text("Something went wrong"),
                           duration: Duration(seconds: 1),
                      ));
                    }
                  },
                  child: GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                        // AppRoutes.pop(context);
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedLogout03,
                        color: Colors.black,
                        size: 24.0.r,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
