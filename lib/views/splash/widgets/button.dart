import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_b2c/blocs/auth/auth_bloc.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../../../blocs/splash/splash_bloc.dart';
import '../../../configs/colors.dart';
import '../../../widgets/app_button.dart';

class Button extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const Button({
    super.key,
    required this.formKey, required this.emailController, required this.passwordController, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    // print("email: ${emailController.text}");
    return Column(
      children: [
        BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is ShowLoginFormState) {
              return Column(
                children: [
                  AppButton(
                    width: 400.w,
                    text: "Login",
                    press: () {
                      if(formKey.currentState!.validate()){
                        context.read<AuthBloc>().add(LoginEvent(email: emailController.text.trim(), password: passwordController.text.trim()));
                      }
                    },
                    color: AppColors.blue,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.textColorw3,endIndent: 10.w,)),
                      Text("Or", style: myText(color: AppColors.textColorw1),),
                      Expanded(child: Divider(color: AppColors.textColorw3, indent: 10.w,)),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  TextButton(onPressed: (){
                  }, child: RichText(
                    text: TextSpan(
                      style: myText(
                        color: AppColors.textColorw1,
                        // fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Register Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),)
                ],
              );
            }
            return AppButton(
              width: 400.w,
              text: "Get Started",
              press: () {
                context.read<SplashBloc>().add(ShowLoginFormEvent());
              },
              color: AppColors.blue,
            );
          },
        ),
      ],
    );
  }
}
