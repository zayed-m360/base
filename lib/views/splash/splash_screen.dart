import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_in_store_app_version_checker/flutter_in_store_app_version_checker.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> getData() async {
    await LocalDB.getLoginInfo().then((myData) {
      if (myData == null) {
        Future.delayed(const Duration(milliseconds: 5), () {
          // AppRoutes.pushAndRemoveUntil(
          //   context,
          //   const RootScreen(),
          // );
        });
        return;
      }

      AppUrls.logger.f("message myData: ${myData.length}");
      email = myData[0];
      password = myData[1];
      token = myData[2];
      // context.read<AuthBloc>().add(DoLoginEvent(email: '$email', password: '$password'));
      Future.delayed(const Duration(milliseconds: 5), () {
        // AppRoutes.pushAndRemoveUntil(
        //   context,
        //   const RootScreen(),
        // );
      });
    });

    setState(() {});
  }

  Future<void> appUpdateAlert(context) async{

    final alert = AlertDialog.adaptive(
      title: const Text("Update App?"),
      content: const Text("A new version of ${AppConstants.appName} is available!"),
      actions: [
        TextButton(
            onPressed: (){
              getData();
            },
            child: const Text("Later")
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
              if(Platform.isIOS){
                launchAppStore(AppUrls.appStoreLink);
              } else {
                launchAppStore(AppUrls.playStoreLink);
              }
            },
            child: const Text("Update Now")
        ),
      ],
    );


    final checker = InStoreAppVersionChecker();
    final canUpdate = await checker.checkUpdate().then((value) => value.canUpdate);

    if(canUpdate){
      showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else{
      getData();
    }

  }

  Future<void> launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    var uri = Uri.parse(appStoreLink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }

  @override
  void initState() {
    super.initState();
    appUpdateAlert(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: Center(
      //   child: Image.asset(
      //     "assets/images/app_icon.png",
      //     height: 100,
      //     width: 100,
      //   ),
      // ),
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
