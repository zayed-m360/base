import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';

import '../configs/colors.dart';

Future<void> appAlertDialog(
    BuildContext context,
    {
      List<Widget> actions = const <Widget>[],
      bool barrierDismissible = false,
      String? title,
      Color color = AppColors.bg,
      required Widget content
    }) async {
  final alert = AlertDialog(
    titlePadding: EdgeInsets.zero,
    title: Text(title??"",style: myText(color: AppColors.textColorb1),),
    content: content,
    actions: actions,
  );

  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> appLoadingDialog(BuildContext context) {
  return appAlertDialog(
    context,
    content: SizedBox(
      height: 200.h,
      child: Column(
        children: [
          SizedBox(
            height: 150.h,
            width: 150.w,  // Added width constraint
            child: Lottie.asset('assets/animations/loading.json'),
          ),
          Text(
            "Loading.....",
            style: myText(
              color: AppColors.textColorb1,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
