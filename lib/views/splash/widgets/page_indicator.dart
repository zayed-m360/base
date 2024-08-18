import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/splash/splash_bloc.dart';
import '../../../configs/app_routes.dart';
import '../../../configs/colors.dart';
import '../../../widgets/app_text_style.dart';
import '../../root.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      buildWhen: (previous, current) => current is! ShowSentOTPFormState,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Skip", style: myText(color: Colors.transparent),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  width: state is ShowLoginFormState || state is ShowSentOTPFormState ? 10.h : 30.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: state is ShowLoginFormState || state is ShowSentOTPFormState
                        ? AppColors.bg
                        : AppColors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
                SizedBox(
                  width: 10.w,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: state is! ShowLoginFormState ? 10.h : 30.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: state is! ShowLoginFormState
                        ? AppColors.bg
                        : AppColors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if(state is ShowLoginFormState){
                  AppRoutes.pushAndRemoveUntil(context, const RootScreen());
                }
              },
              child: Text("Skip", style: myText(color: state is ShowLoginFormState ? AppColors.textColorw1 : Colors.transparent),)
            )
          ],
        );
      },
    );
  }
}

