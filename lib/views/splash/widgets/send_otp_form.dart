import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_b2c/configs/app_constants.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';
import '../../../blocs/splash/splash_bloc.dart';
import '../../../configs/colors.dart';
import '../../../widgets/app_text_field.dart';

class SendOtpForm extends StatelessWidget {
  const SendOtpForm({
    super.key,
    required this.emailController, required this.formKey,
  });

  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            textInputAction: TextInputAction.done,
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
          SizedBox(
            height: 105.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  context.read<SplashBloc>().add(ShowLoginFormEvent());
              }, child: Text("Go to Login", style: myText(color: AppColors.textColorw1),))
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
