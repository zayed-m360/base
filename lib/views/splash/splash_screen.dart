import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../configs/app_constants.dart';
import '../../configs/app_sizes.dart';
import '../../configs/app_urls.dart';
import '../../configs/colors.dart';
import '../../database/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String? token, email, password;
  AppUpdateInfo? _updateInfo;

  Future<AppUpdateInfo?> checkForUpdate() async {
    try {
      AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      if (!mounted) return null; // Ensure the widget is still mounted
      setState(() {
        _updateInfo = info;
      });
      if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
        appUpdateAlert(context);
      }
    } catch (e) {
      debugPrint('$e');
    }
    return _updateInfo;
  }

  Future<void> getData() async {
    await LocalDB.getLoginInfo().then((myData) {
      if (!mounted) return; // Ensure the widget is still mounted
      if (myData == null) {
        Future.delayed(const Duration(milliseconds: 5), () {
          // Navigate to your next screen
        });
        return;
      }

      AppUrls.logger.f("message myData: ${myData.length}");
      email = myData[0];
      password = myData[1];
      token = myData[2];
      // Trigger login and navigate to home screen
    });

    if (mounted) setState(() {});
  }

  Future<void> appUpdateAlert(context) async {
    final alert = AlertDialog.adaptive(
      title: const Text("Update App?"),
      content: const Text("A new version of ${AppConstants.appName} is available!"),
      actions: [
        TextButton(
            onPressed: () {
              getData();
            },
            child: const Text("Later")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              InAppUpdate.performImmediateUpdate();
            },
            child: const Text("Update Now")),
      ],
    );
    showAdaptiveDialog(context: context,
      builder: (context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.bodyPadding),
        child: Text.rich(
          TextSpan(
            text: 'Product of ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
            children: [
              TextSpan(
                text: "M360 ICT",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.seed,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
