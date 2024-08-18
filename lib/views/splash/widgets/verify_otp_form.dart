import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_b2c/blocs/otp/otp_bloc.dart';
import 'package:ota_b2c/configs/app_constants.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';
import '../../../blocs/splash/splash_bloc.dart';
import '../../../blocs/timer/timer_bloc.dart';
import '../../../configs/colors.dart';

class VerifyOtpForm extends StatelessWidget {
  const VerifyOtpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OtpBloc otpBloc = BlocProvider.of<OtpBloc>(context);
    final TimerBloc timerBloc = BlocProvider.of<TimerBloc>(context);
    timerBloc.add(TimerStartEvent(180));//3 minutes
    return Column(
      children: [
        OtpTextField(
          numberOfFields: 6,
          borderColor: const Color.fromARGB(255, 255, 255, 255),
          showFieldAsBox: true,
          enabledBorderColor: const Color.fromARGB(255, 255, 255, 255),
          cursorColor: AppColors.blue,
          focusedBorderColor: AppColors.blue,
          textStyle: const TextStyle(color: Colors.white),
          onSubmit: (String verificationCode) {
            otpBloc.otp = verificationCode;
            logger.i("otp: ${otpBloc.otp}}");
            otpBloc.add(VerifyOtpEvent(otp: otpBloc.otp ?? ""));
          },
        ),
        SizedBox(
          height: 105.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                if(state is TimerCompleteState){
                  return GestureDetector(onTap: () {
                    otpBloc.fromResend = true;
                    context.read<OtpBloc>().add(SendOtpEvent(email: otpBloc.email??""));
                    context.read<TimerBloc>().add(TimerStartEvent(180));
                  }, child: Text("Resend OTP", style: myText(color: AppColors.blue, fontSize: 14.sp, fontWeight: FontWeight.bold),));
                }else if(state is TimerRefreshState){
                  return GestureDetector(onTap: () {}, child: Row(
                    children: [
                      Text("Resend OTP", style: myText(color: AppColors.blue.withOpacity(0.5), fontSize: 14.sp, fontWeight: FontWeight.w400),),
                      Text(" (${state.minutes}:${state.seconds})", style: myText(color: AppColors.blue, fontSize: 14.sp, fontWeight: FontWeight.w400),),
                    ],
                  ));
                }
                return TextButton(onPressed: () {}, child: const Text(""));
              },
            ),
            GestureDetector(
                onTap: () {
                  context.read<SplashBloc>().add(ShowLoginFormEvent());
                },
                child: Text(
                  "Go to Login",
                  style: myText(color: AppColors.textColorw1),
                ))
          ],
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
