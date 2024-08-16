import 'package:flutter/material.dart';
import 'package:ota_b2c/configs/colors.dart';

TextStyle myText({Color color = AppColors.textColorb1, FontWeight fontWeight = FontWeight.w300, int fontSize = 14}){
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize.toDouble());
}