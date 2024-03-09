import 'package:flutter/material.dart';
import 'package:qr_ieee/presentation/screens/ScanScreen.dart';
import 'package:qr_ieee/presentation/screens/homeScreen.dart';
import 'package:qr_ieee/presentation/screens/splashScreen.dart';

import 'apporoute.dart';
import 'constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sprit',
      onGenerateRoute: AppRoutes().generateRoute,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName :(_)=>SplashScreen(),
        HomeScreen.routeName :(_)=>HomeScreen(),
        ScanScreen.routeName :(_)=>ScanScreen(),

      },
    );
  }
}

