import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_b2c/blocs/auth/auth_bloc.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../../../blocs/otp/otp_bloc.dart';
import '../../../blocs/splash/splash_bloc.dart';
import '../../../configs/colors.dart';
import '../../../widgets/app_button.dart';

class Button extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const Button({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController, required this.newPasswordController, required this.nameController, required this.phoneController, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    // print("email: ${emailController.text}");
    final OtpBloc otpBloc = BlocProvider.of<OtpBloc>(context);
    return Column(
      children: [
        BlocBuilder<OtpBloc, OtpState>(
          builder: (context, otpState) {
            if (otpState is ShowOTPFormState) {
              return AppButton(
                width: 400.w,
                text: "Verify",
                press: () {
                  context.read<OtpBloc>().add(VerifyOtpEvent(otp: otpBloc.otp??""));
                },
                color: AppColors.blue,
              );
            } else if (otpState is ShowPasswordFormState) {
              return AppButton(
                width: 400.w,
                text: "Reset Password",
                press: () {
                  if (formKey.currentState!.validate()) {
                    context.read<OtpBloc>().add(ResetPasswordEvent(newPassword: newPasswordController.text,));
                  }
                },
                color: AppColors.blue,
              );
            } else{
              return BlocBuilder<SplashBloc, SplashState>(
                builder: (context, splashState) {
                  if (splashState is ShowLoginFormState) {
                    return Column(
                      children: [
                        AppButton(
                          width: 400.w,
                          text: "Login",
                          press: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(LoginEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim()));
                            }
                          },
                          color: AppColors.blue,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: AppColors.textColorw3,
                              endIndent: 10.w,
                            )),
                            Text(
                              "Or",
                              style: myText(color: AppColors.textColorw1),
                            ),
                            Expanded(
                                child: Divider(
                              color: AppColors.textColorw3,
                              indent: 10.w,
                            )),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        TextButton(
                          onPressed: () {
                            context.read<SplashBloc>().add(ShowSignupFormEvent());
                          },
                          child: RichText(
                            text: TextSpan(
                              style: myText(
                                color: AppColors.textColorw1,
                                // fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                              ),
                              children: <TextSpan>[
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: 'Register Now',
                                  style: myText(color: AppColors.blue, fontSize: 14.sp, fontWeight: FontWeight.bold)
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (splashState is ShowSignupFormState) {
                    return AppButton(
                      width: 400.w,
                      text: "Sign Up",
                      press: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SignupEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(), 
                                  phone: phoneController.text.trim(),
                                  name: nameController.text.trim()));
                        }
                      },
                      color: AppColors.blue,
                    );
                  } else if (splashState is ShowSentOTPFormState) {
                    return AppButton(
                      width: 400.w,
                      text: "Send OTP",
                      press: () {
                        if (formKey.currentState!.validate()) {
                          context.read<OtpBloc>().fromResend = false;
                          context.read<OtpBloc>().add(SendOtpEvent(email: emailController.text));
                        }
                      },
                      color: AppColors.blue,
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
              );
            }
          },
        ),
      ],
    );
  }
}
