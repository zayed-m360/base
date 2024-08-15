import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:ota_b2c/configs/app_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'configs/theme.dart';
import 'views/home/home_page.dart';

Future<void> main() async {
  //!for local db
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

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
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme, // Use the custom theme here,
      home: const HomePage(),
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
