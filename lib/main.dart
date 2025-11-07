import 'dart:io';

import 'package:binghan_mobile/_config/theme.dart';
import 'package:binghan_mobile/firebase_options.dart';
import 'package:binghan_mobile/views/_widgets/Alert/Dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_config/router.dart' as router;
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

void main() async {
  setupLocator();
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binghan Mobile',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: widget!),
        ),
      ),
      theme: MyTheme.mainThemes,
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.SplashRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
