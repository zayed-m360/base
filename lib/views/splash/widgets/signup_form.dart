import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ota_b2c/blocs/splash/splash_bloc.dart';
import 'package:ota_b2c/configs/app_constants.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../../../blocs/password/password_bloc.dart';
import '../../../configs/colors.dart';
import '../../../widgets/app_text_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.emailController,
    required this.passwordController, 
    required this.formKey, 
    required this.nameController, 
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            textInputAction: TextInputAction.next,
            labelText: "Name",
            hintText: "Enter your Name",
            keyboardType: TextInputType.name,
            controller: nameController,
            labelColor: AppColors.textColorw1,
            hintColor: AppColors.textColorw3,
            fillColor: AppColors.bg.withOpacity(0.1),
            textColor: AppColors.textColorw1,
            isRequired: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your name";
              }
              return null; // No errors found
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  textInputAction: TextInputAction.next,
                  labelText: "Email",
                  hintText: "Enter your Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  labelColor: AppColors.textColorw1,
                  hintColor: AppColors.textColorw3,
                  fillColor: AppColors.bg.withOpacity(0.1),
                  textColor: AppColors.textColorw1,
                  isRequired: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email address";
                    } else if (!AppConstants.emailRegex.hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null; // No errors found
                  },
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: AppTextField(
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("+880", style: myText(color: AppColors.textColorw3),),
                    ],
                  ),
                  textInputAction: TextInputAction.next,
                  labelText: "Phone number",
                  hintText: "Enter your pone number",
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  labelColor: AppColors.textColorw1,
                  hintColor: AppColors.textColorw3,
                  fillColor: AppColors.bg.withOpacity(0.1),
                  textColor: AppColors.textColorw1,
                  isRequired: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a phone number";
                    }
                    return null; // No errors found
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<PasswordBloc, PasswordState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<PasswordBloc>(context);
              return AppTextField(
                obscureText: !bloc.passwordVisible,
                textInputAction: TextInputAction.done,
                labelText: "Password",
                hintText: "Enter your password",
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                labelColor: AppColors.textColorw1,
                hintColor: AppColors.textColorw3,
                fillColor: AppColors.bg.withOpacity(0.1),
                textColor: AppColors.textColorw1,
                isRequired: true,
                suffixIcon: !bloc.passwordVisible ?  GestureDetector(
                  onTap: () {
                    bloc.add(TogglePasswordEvent());
                  },
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedViewOff,
                    color: AppColors.textColorw1,
                    size: 24.0.r,
                  ),
                ) : GestureDetector(
                  onTap: () {
                    bloc.add(TogglePasswordEvent());
                  },
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedView,
                    color: AppColors.textColorw1,
                    size: 24.0.r,
                  ),
                ),
                validator: (p0) => p0!.isEmpty ? "Please Enter Password" : null,
              );
            },
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<SplashBloc>().add(ShowLoginFormEvent());
                },
                child: Text(
                  "Go to Login",
                  style: myText(color: AppColors.textColorw1),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
