/*
appAlertDialog
@Author Soton Ahmed <soton.m360ict@gmail.com>
Start Date: 12-12-2023
Last Update: 12-12-2023
*/

import 'package:flutter/material.dart';

import '../configs/app_sizes.dart';
import '../configs/colors.dart';

Future<void> appAlertDialog(
    BuildContext context,
    String content, {
      List<Widget> actions = const <Widget>[],
      bool barrierDismissible = false,
      String? title,
      Color color = AppColors.seed,
      IconData icon = Icons.warning
    }) async {
  final alert = AlertDialog(
    titlePadding: EdgeInsets.zero,
    title: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(27))
      ),
        padding: const EdgeInsets.all(AppSizes.bodyPadding),
        child: Row(
          children: [
            Icon(icon, color: AppColors.bg,),
            const SizedBox(width: 10,),
            Text(title??"Notice",style: const TextStyle(color: AppColors.bg),),
          ],
        )),
    content: content.isEmpty ? null : Text(content),
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
