import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ota_b2c/blocs/splash/splash_bloc.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../../../blocs/password/password_bloc.dart';
import '../../../configs/colors.dart';
import '../../../widgets/app_text_field.dart';

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({
    super.key,
    required this.newPasswordController, required this.formKey,
  });

  final TextEditingController newPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [

          BlocBuilder<PasswordBloc, PasswordState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<PasswordBloc>(context);
              return AppTextField(
                obscureText: !bloc.passwordVisible,
                textInputAction: TextInputAction.done,
                labelText: "New Password",
                hintText: "Enter your new password",
                keyboardType: TextInputType.emailAddress,
                controller: newPasswordController,
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
