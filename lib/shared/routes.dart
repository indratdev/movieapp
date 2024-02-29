import 'package:flutter/material.dart';
import 'package:movie_app/views/login/login_screen.dart';
import 'package:movie_app/views/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';

  Map<String, WidgetBuilder> getRoutes = {
    splashScreen: (_) => SplashScreen(),
    loginScreen: (_) => LoginScreen(),
  };
}
