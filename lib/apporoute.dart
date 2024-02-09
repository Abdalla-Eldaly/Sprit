import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_ieee/presentation/screens/ScanScreen.dart';
import 'package:qr_ieee/presentation/screens/homeScreen.dart';
import 'package:qr_ieee/presentation/screens/splashScreen.dart';

import 'business_logic/character_cubit.dart';
import 'constants/strings.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreenRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(), // Navigate to the splash screen
        );
      case HomeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharacterCubit(),
            child: HomeScreen(),
          ),
        );
      case ScanScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharacterCubit(),
            child: ScanScreen(),
          ),
        );

    }
  }
}
