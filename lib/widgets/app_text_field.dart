/*
App Text Form Field
@Author Soton Ahmed <soton.m360ict@gmail.com>
Start Date: 28-11-2023
Last Update: 28-11-2023
*/

import 'package:flutter/material.dart';

import '../configs/app_sizes.dart';
import '../configs/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {required this.textInputAction,
      required this.labelText,
      required this.hintText,
      required this.keyboardType,
      required this.controller,
      super.key,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.suffixIcon,
      this.onEditingComplete,
      this.autofocus,
      this.focusNode,
      this.readOnly = false});

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final String hintText;
  final bool? autofocus;
  final bool readOnly;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: autofocus ?? false,
        validator: validator,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        onEditingComplete: onEditingComplete,
        readOnly: readOnly,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          isDense: true,
          filled: true,
          fillColor: AppColors.bg,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(color: AppColors.textColorb3),
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey.shade500),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.bodyPadding - 5),
              borderSide: BorderSide(color: AppColors.error(context),width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.bodyPadding - 5),
              borderSide: const BorderSide(color: AppColors.seed,width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.bodyPadding - 5),
              borderSide: const BorderSide(color: AppColors.primary,width: 0.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.bodyPadding - 5),
              borderSide: BorderSide(color: AppColors.error(context),width: 0.5)),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
