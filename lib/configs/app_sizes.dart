import 'package:flutter/material.dart';

class AppSizes{
  static const double bodyPadding     = 10;
  static const double preferredBottom = 10;

  static double height(context) => MediaQuery.sizeOf(context).height;
  static double width(context)  => MediaQuery.sizeOf(context).width;
}