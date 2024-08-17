import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_b2c/configs/app_sizes.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../configs/colors.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {super.key,
      required this.text,
      required this.press,
      this.width,
      this.color = AppColors.primary,
      this.align,
      this.radius,
      this.height,
      this.txtColor});

  final String? text;
  final VoidCallback press;
  final Color? color;
  final Color? txtColor;
  final double? width;
  final Alignment? align;
  double? radius;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        // height: height ?? 40.h,
        width: width ?? AppSizes.width(context),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
              Radius.circular(radius ?? AppSizes.borderRadius)),
        ),
        child: Center(
          child: Text(
            '$text',
            style: myText(
                color: txtColor ?? AppColors.textColorw1,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }
}
