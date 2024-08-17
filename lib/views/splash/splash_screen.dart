import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_b2c/blocs/auth/auth_bloc.dart';
import 'package:ota_b2c/configs/app_routes.dart';
import 'package:ota_b2c/configs/app_sizes.dart';
import 'package:ota_b2c/views/root.dart';
import 'package:ota_b2c/views/splash/widgets/button.dart';
import 'package:ota_b2c/views/splash/widgets/page_indicator.dart';
import 'package:ota_b2c/widgets/app_alert_dialog.dart';
import 'package:ota_b2c/widgets/app_text_style.dart';
import '../../blocs/splash/splash_bloc.dart';
import '../../configs/colors.dart';
import 'widgets/login_form.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthBloc previousLoginBloc;

  @override
  void initState() {
    previousLoginBloc = BlocProvider.of<AuthBloc>(context);
    previousLoginBloc.add(InitialFetchLoginDataEvent());
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // listenWhen: (previous, current) => current is PreviousLoginActionState,
      listener: (context, state) {
        if(state is LoginSuccessState){
          AppRoutes.pushAndRemoveUntil(context, const RootScreen());
        } else if(state is AuthLoadingState){
          appLoadingDialog(context);
        } else if(state is ErrorState){
          AppRoutes.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong", style: myText(color: AppColors.textColorw1),),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(10.r, 0.r, 10.r, 10.r),
          width: double.maxFinite,
          height: AppSizes.height(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.7, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.primary, Color.fromARGB(255, 6, 23, 43)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25.w,
                        ),
                        Image.asset(
                          'assets/images/plane_bg.png',
                          height: 350.h,
                        ),
                      ],
                    ),
                    BlocBuilder<SplashBloc, SplashState>(
                      builder: (context, state) {
                        if (state is ShowLoginFormState) {
                          return LoginForm(
                            emailController: emailController,
                            passwordController: passwordController,
                            formKey: _formKey,
                          );
                        }
                        return Column(
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            RichText(
                              text: TextSpan(
                                style: myText(
                                  color: AppColors.textColorw1,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(text: 'Easiest way to\n'),
                                  TextSpan(
                                    text: 'Book ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(text: 'your flight'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200.h,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is NoPreviousDataState || state is ErrorState || state is AuthLoadingState) {
                      
                      return Column(
                        children: [
                          Button(
                            formKey: _formKey, emailController: emailController, passwordController: passwordController,
                          ),
                          SizedBox(height: 20.h),
                          const PageIndicator()
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
