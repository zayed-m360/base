import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:ota_b2c/blocs/password/password_bloc.dart';
import 'package:ota_b2c/blocs/splash/splash_bloc.dart';
import 'package:ota_b2c/configs/app_constants.dart';
import 'package:ota_b2c/views/splash/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/root/root_bloc.dart';
import 'configs/theme.dart';

Future<void> main() async {
  //!for local db
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // await LocalDB.postLoginInfo(email: "zayedoyshik@gmail.com", password: "12345678", token: "token");

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  

  // HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>RootBloc()),
        BlocProvider(create: (context)=>SplashBloc()),
        BlocProvider(create: (context)=>PasswordBloc()),
        BlocProvider(create: (context)=>AuthBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(411, 867),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme, // Use the custom theme here,
          home: child
        ),
        // child: const RootScreen(),
        child: const SplashScreen(),
      ),
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
