import 'package:flutter/material.dart';
import 'package:qr_ieee/presentation/screens/ScanScreen.dart';
import 'package:qr_ieee/presentation/screens/generateScreen.dart';
import 'package:qr_ieee/presentation/screens/homeScreen.dart';
import 'package:qr_ieee/presentation/screens/splashScreen.dart';

import 'apporoute.dart';
import 'constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IEEE',
      onGenerateRoute: AppRoutes().generateRoute,
      initialRoute: SplashScreenRoute,
      routes: {
        SplashScreen.routeName :(_)=>SplashScreen(),
        HomeScreen.routeName :(_)=>HomeScreen(),
        ScanScreen.routeName :(_)=>ScanScreen(),
        GenerateScreen.routeName :(_)=>GenerateScreen(),
      },
    );
  }
}

